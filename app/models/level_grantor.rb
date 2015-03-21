# Public: Concede a new level to an user
# in an universe.
class LevelGrantor
  # Public: Upgrade the user level value by 1
  # and schedule a notification to the user.
  #
  # user - the User that will have the level upgraded.
  # universe - the Universe context to be evaluated.
  #
  # Returns the level with the value updated, or nil if
  # user and universe do not meet the criteria to the
  # next level.
  def self.level_up!(user, universe)
    evaluator = LevelEvaluator.new(user, universe)

    if evaluator.can_level_up?
      level = Level.find_by(user: user, universe: universe)
      level.value += 1
      level.save!

      RankNotificationJob.perform_later(user, level.rank)

      level
    end
  end
end
