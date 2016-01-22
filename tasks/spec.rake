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

	task :all => [:cell, :grid]
end

task :default => "models:all"