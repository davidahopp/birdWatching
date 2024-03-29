set :application, "birdWatching"
set :repository,  "git@github.com:davidahopp/birdWatching.git"
set :scm, :git
set :branch, 'master'
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true
set :keep_releases, 3
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/ubuntu/www/birdWatching"

#role :web, "davidahopp.com"                          # Your HTTP server, Apache/etc
#role :app, "davidahopp.com"                          # This may be the same as your `Web` server
#role :db,  "davidahopp.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
server "davidahopp.com", :app, :web, :db, :primary => true

set :user, 'ubuntu'
ssh_options[:keys] = ["/home/david/.ssh/dahkey.pem"]

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.
require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user
set :bundle_without,  [:development, :test]

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end

   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

namespace :assets do
  task :precompile do
    run "cd #{current_path} && bundle exec rake assets:precompile"
  end
  task :clean do
    run "cd #{current_path} && bundle exec rake assets:clean"
  end
  task :cleanup do
    assets.clean
    assets.precompile
  end
end

namespace :db do

  task :setup do
    run "ln -sf #{shared_path}/database.yml #{current_path}/config/"
  end

  task :migrate do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:migrate"
  end

  task :rollback do
    if previous_release
      run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:migrate VERSION=`cat #{previous_release}/migration_version.txt`"
    end
  end

  task :set_version do
    run "cd #{release_path} && bundle exec rake RAILS_ENV=production db:current_version > migration_version.txt"
  end


end

after "deploy:update", "db:setup"
after "db:setup", "db:migrate"
after "db:migrate", "db:set_version"
after "deploy:restart", "deploy:cleanup"
before "deploy:restart", "assets:cleanup"

before "deploy:rollback", "db:rollback"
after "deploy:rollback:revision", "bundle:install"
after "deploy:update_code", "bundle:install"
