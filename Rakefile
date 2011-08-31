require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

CONFIG = File.open('config/database.yml') { |yf| YAML::load yf  }

task :default => ['test:deploy', 'test:features']

namespace :test do

  task :deploy do
    sh 'couchapp push test'
  end

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty"
  end

end
