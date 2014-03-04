# Public: Calculate points and levels for a given
# user in a given universe.
class LevelsCalculator
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
  # user - A Raddar::User for whom the level will be calculated.
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

  # Public: Calculate the level the user is according
  # to its score in the universe.
  #
  # Starting with the score necessary to go from level 1
  # to level 2, defined by LEVEL_1_GOAL, each level requires
  # the amount of points that was necessary in the previous
  # level plus 50%.
  #
  # Returns an Integer number of the user level.
  def level
    level = 1
    to_next = LEVEL_1_GOAL

    while points >= to_next
      to_next += (LEVEL_1_GOAL * (1.5 ** level)).to_i
      level += 1
    end

    level
  end
end
