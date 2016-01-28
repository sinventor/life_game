namespace :models do
	task :bunch do
		Dir["spec/models/**/*.rb"].each do |file|
			sh "bundle exec rspec #{file}"
		end
	end

	task :cell do
		sh "bundle exec rspec spec/models/cell.rb"
	end

	task :grid do
		sh "bundle exec rspec spec/models/grid.rb"
	end

	task :game do
		sh "bundle exec rspec spec/models/game_spec.rb"
	end

	task :all => [:cell, :grid]
end

namespace :controllers do
	task :game do
		sh "bundle exec rspec spec/controllers/games_controller_spec.rb"
	end

	task :grid do
		sh "bundle exec rspec spec/controllers/grids_controller_spec.rb"
	end

	task :all => [:game, :grid]
end

task :default => ["models:all", "controllers:all"]