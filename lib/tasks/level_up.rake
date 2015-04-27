namespace :mundodastrevas do
  namespace :level_up do
    desc 'Check all users and universes to check if someone can level up'
    task check: :environment do
      Universe.all.each do |universe|
        next if universe.ranks.empty?

        puts "########### #{universe} ###########"

        User.all.each do |user|
          evaluator = LevelEvaluator.new(user, universe)

          next unless evaluator.can_level_up?

          current = Level.find_by(user: user, universe: universe)
          intended = Rank.find_by(
            universe: universe, value: current.value + 1
          )

          puts(
            "#{user} can go from #{current.value} - #{current.rank}, "\
            "earned at #{current.updated_at || current.created_at}, to "\
            "#{intended.value} - #{intended}"
          )
        end
      end
    end

    desc 'Level up all eligible users in all universes'
    task perform: :environment do
      Universe.all.each do |universe|
        next if universe.ranks.empty?

        puts "########### #{universe} ###########"

        User.all.each do |user|
          level = LevelGrantor.level_up!(user, universe)
          puts "#{user} grew to level #{level.value} - #{level.rank}" if level
        end
      end
    end
  end
end
