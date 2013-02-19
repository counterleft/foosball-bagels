require "bundler/capistrano"

set :bundle_flags, "--deployment --binstubs"

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :application, "Bagel Central"
set :repository,  "git://github.com/winterchord/foosball-bagels.git"

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

task :precompile, :role => :app do  
  run "cd #{release_path}/ && rake assets:precompile"  
end  

after "deploy:finalize_update", "deploy:precompile"
