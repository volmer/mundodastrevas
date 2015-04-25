# Public: Calculate points and levels for a given
# user in a given universe.
class LevelEvaluator
  # Private: Integer number of reviews an item must have
  # to be evaluated its relevance.
  RELEVANT_REVIEWS = 3

  # Private: Integer number of points for a forum pust.
  FORUM_POST_BASE = 1

  # Private: Integer number of points for a zine post.
  ZINE_POST_BASE = 3

  # Private: Integer number of points for a comment.
  COMMENT_BASE = 1

  # Private: An integer number of points a user must have
  # to go from level 1 to 2.
  LEVEL_1_GOAL = 7

  attr_accessor :user, :universe

  # Public: Initialize the calculator.
  #
  # user - A User for whom the level will be calculated.
  # universe - An Universe for whom the level will be calculated.
  def initialize(user, universe)
    @user     = user
    @universe = universe
  end

  # Public: Verify if a given reviewable item is relevant or not
  # for levels purposes.
  #
  # Returns true if the item has at least the amount of reviews
  # defined by RELEVANT_REVIEWS and has more positive reviews
  # than negative ones, or false otherwise.
  def relevant?(reviewable)
    loved = reviewable.reviews.where(value: 'loved').count
    hated = reviewable.reviews.where(value: 'hated').count

    (reviewable.reviews.count >= RELEVANT_REVIEWS) && (loved > hated)
  end

  # Public: Calculate the points the user has scored in the universe
  # by evaluating all its contributions in forum posts, zine posts
  # and comments. Each item gives the user an amount of points defined
  # by its respective base points constant. Relevant items give points
  # in double.
  #
  # Returns an Integer with the total score of the user in the universe.
  def score
    points = 0

    @user.reload

    @user.forum_posts.each { |post| points += points_in_forum_post(post) }
    @user.posts.each { |post| points += points_in_post(post) }
    @user.comments.each { |comment| points += points_in_comment(comment) }

    points
  end

  # Public: Calculate the score necessary to
  # pass to the next level.
  #
  # Starting with the score necessary to go from level 1
  # to level 2, defined by LEVEL_1_GOAL, each level requires
  # the amount of points that was necessary in the previous
  # level plus 50%.
  #
  # Returns an Integer number of points necessary.
  def to_next_level
    level = 1
    points = 0

    while level < intended_level
      points += (LEVEL_1_GOAL * (1.5**(level - 1))).to_i
      level += 1
    end

    (points - score) > 0 ? (points - score) : 0
  end

  # Public: Check if the user can have its level upgraded
  # in the given universe.
  #
  # Returns true if the user is active, if it already has
  # the required score to the next level and if the given
  # universe has a rank associated to the intended value,
  # false otherwise.
  def can_level_up?
    @user.active? &&
      to_next_level == 0 &&
      intended_level <= (universe.highest_rank.try(:value) || 0)
  end

  private

  # Internal: The next level the user need to
  # acquire.
  #
  # Returns an Integer with the next level value
  # the user is intended to.
  def intended_level
    (@user.rank_in(@universe).try(:value) || 1) + 1
  end

  def points_in_post(post)
    return 0 if post.zine.universe != @universe
    ZINE_POST_BASE * (relevant?(post) ? 2 : 1)
  end

  def points_in_forum_post(forum_post)
    return 0 if forum_post.topic.forum.universe != @universe
    FORUM_POST_BASE * (relevant?(forum_post) ? 2 : 1)
  end

  def points_in_comment(comment)
    return 0 if comment.post.zine.universe != @universe
    COMMENT_BASE * (relevant?(comment) ? 2 : 1)
  end
end
