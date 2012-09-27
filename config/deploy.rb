require "bundler/capistrano"

require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.2'        # Or whatever env you want it to run in.
set :rvm_type, :user

set :application, "Bagel Central"
set :repository,  "git://github.com/bmthykm/foosball-bagels.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, 
# `perforce`, `subversion` or `none`

role :web, "rarevisions.net"  # Your HTTP server, Apache/etc
role :app, "rarevisions.net"  # This may be the same as your `Web` server
role :db,  "rarevisions.net", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :port, 220

set :deploy_to, "/var/www/foosball"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# namespace :bundler do
#   task :install do
#     run "cd #{current_path} && bundle install --no-cache --disable-shared-gems"
#   end
# end
# 
# after("deploy:symlink", "bundler:install")
