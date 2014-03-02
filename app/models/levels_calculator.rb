class LevelsCalculator
  RELEVANT_REVIEWS = 3
  FORUM_POST_BASE = 1
  ZINE_POST_BASE = 3
  COMMENT_BASE = 1
  LEVEL_1_GOAL = 7

  attr_accessor :user, :universe

  def initialize(user, universe)
    @user     = user
    @universe = universe
  end

  def relevant?(reviewable)
    loved = reviewable.reviews.where(value: 'loved').count
    hated = reviewable.reviews.where(value: 'hated').count

    (reviewable.reviews.count >= RELEVANT_REVIEWS) && (loved > hated)
  end

  def points
    points = 0

    @user.reload

    @user.forum_posts.each do |post|
      points += (FORUM_POST_BASE * (relevant?(post) ? 2 : 1)) if post.topic.forum.universe == @universe
    end

    @user.zine_posts.each do |post|
      points += (ZINE_POST_BASE * (relevant?(post) ? 2 : 1)) if post.zine.universe == @universe
    end

    @user.zine_comments.each do |comment|
      points += (COMMENT_BASE * (relevant?(comment) ? 2 : 1)) if comment.post.zine.universe == @universe
    end

    points
  end

  def level
    level = 1
    to_next = LEVEL_1_GOAL

    while points >= to_next
      to_next += (LEVEL_1_GOAL * (1.5 ** level)).to_i
      level += 1
    end

    level
  end

  def grant(commit = false)
    Universe.each do |universe|
      if universe.ranks.present?
        User.where(state: 'active').each do |user|
          intended_value = user.rank_in(universe).value + 1

          if intended_value <= universe.highest_rank.level
            points = calc_points user, universe
            level = calc_level points

            if level >= intended_level
              rank = universe.ranks.where(level: intended_level).first
              user.ranks << rank

              Delayed::Job.enqueue NotifyRankJob.new(user.id, rank.id)
            end
          end
        end
      end
    end
  end
end
