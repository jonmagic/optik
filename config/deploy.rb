# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "optik"
set :repository, "http://store.sabretechllc.com/public/jonmagic/#{application}/trunk"

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.

set :domain, "sixsigma.sabretechllc.com"
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "optik"
set :deploy_to, "/home/sabretechllc/apps/#{application}"

# XXX we may not need this - it doesn't work on windows
set :user, "sabretechllc"
set :repository, "http://store.sabretechllc.com/public/jonmagic/optik/trunk"
set :rails_env, "production"

# Automatically symlink these directories from current/public to shared/public.
# set :app_symlinks, %w{photo, document, asset}

# =============================================================================
# APACHE OPTIONS
# =============================================================================
set :apache_server_name, domain
# set :apache_server_aliases, %w{alias1 alias2}
# set :apache_default_vhost, true # force use of apache_default_vhost_config
# set :apache_default_vhost_conf, "/etc/httpd/conf/default.conf"
# set :apache_conf, "/etc/httpd/conf/apps/#{application}.conf"
# set :apache_ctl, "/etc/init.d/httpd"
# set :apache_proxy_port, 8000
# set :apache_proxy_servers, 2
# set :apache_proxy_address, "127.0.0.1"
# set :apache_ssl_enabled, false
# set :apache_ssl_ip, "127.0.0.1"
# set :apache_ssl_forward_all, false
# set :apache_ssl_chainfile, false


# =============================================================================
# MONGREL OPTIONS
# =============================================================================
set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"
set :mongrel_servers, 3
set :mongrel_port, 5000
set :mongrel_address, "127.0.0.1"
set :mongrel_environment, "production"
# set :mongrel_user, nil
# set :mongrel_group, nil
# set :mongrel_prefix, nil

# =============================================================================
# MYSQL OPTIONS
# =============================================================================


# =============================================================================
# SSH OPTIONS
# =============================================================================
# ssh_options[:keys] = %w(/path/to/my/key /path/to/another/key)
# ssh_options[:port] = 25
# =============================================================================
# TASKS
# =============================================================================
# Define tasks that run on all (or only some) of the machines. You can specify
# a role (or set of roles) that each task should be executed on. You can also
# narrow the set of servers to a subset of a role by specifying options, which
# must match the options given for the servers to select (like :primary => true)

desc <<DESC
An imaginary backup task. (Execute the 'show_tasks' task to display all
available tasks.)
DESC
task :backup, :roles => :db, :only => { :primary => true } do
  # the on_rollback handler is only executed if this task is executed within
  # a transaction (see below), AND it or a subsequent task fails.
  on_rollback { delete "/tmp/dump.sql" }

  run "mysqldump -u theuser -p thedatabase > /tmp/dump.sql" do |ch, stream, out|
    ch.send_data "thepassword\n" if out =~ /^Enter password:/
  end
end

# Tasks may take advantage of several different helper methods to interact
# with the remote server(s). These are:
#
# * run(command, options={}, &block): execute the given command on all servers
#   associated with the current task, in parallel. The block, if given, should
#   accept three parameters: the communication channel, a symbol identifying the
#   type of stream (:err or :out), and the data. The block is invoked for all
#   output from the command, allowing you to inspect output and act
#   accordingly.
# * sudo(command, options={}, &block): same as run, but it executes the command
#   via sudo.
# * delete(path, options={}): deletes the given file or directory from all
#   associated servers. If :recursive => true is given in the options, the
#   delete uses "rm -rf" instead of "rm -f".
# * put(buffer, path, options={}): creates or overwrites a file at "path" on
#   all associated servers, populating it with the contents of "buffer". You
#   can specify :mode as an integer value, which will be used to set the mode
#   on the file.
# * render(template, options={}) or render(options={}): renders the given
#   template and returns a string. Alternatively, if the :template key is given,
#   it will be treated as the contents of the template to render. Any other keys
#   are treated as local variables, which are made available to the (ERb)
#   template.

desc "Demonstrates the various helper methods available to recipes."
task :helper_demo do
  # "setup" is a standard task which sets up the directory structure on the
  # remote servers. It is a good idea to run the "setup" task at least once
  # at the beginning of your app's lifetime (it is non-destructive).
  setup

  buffer = render("maintenance.rhtml", :deadline => ENV['UNTIL'])
  put buffer, "#{shared_path}/system/maintenance.html", :mode => 0644
  sudo "killall -USR1 dispatch.fcgi"
  run "#{release_path}/script/spin"
  delete "#{shared_path}/system/maintenance.html"
end

# You can use "transaction" to indicate that if any of the tasks within it fail,
# all should be rolled back (for each task that specifies an on_rollback
# handler).

desc "A task demonstrating the use of transactions."
task :long_deploy do
  transaction do
    update_code
    disable_web
    symlink
    migrate
  end

  restart
  enable_web
end

# my custom stack install, including all necessary packages for rails, mysql, and nginx

task :install_rails_stack_with_nginx do
  setup_user_perms
  enable_universe # we'll need some packages from the 'universe' repository
  disable_cdrom_install # we don't want to have to insert cdrom
  install_packages_for_rails # install packages that come with distribution
  install_rubygems
  install_gems
  install_nginx
end

task :setup_firewall do
  sudo 'echo \'#!/bin/bash\' >> /tmp/firewall.sh'
  sudo 'echo \'sudo iptables -A INPUT -j ACCEPT -p tcp --destination-port 80 -i eth0\' >> /tmp/firewall.sh'
  sudo 'echo \'sudo iptables -A INPUT -j ACCEPT -p tcp --destination-port 443 -i eth0\' >> /tmp/firewall.sh'
  sudo 'echo \'sudo iptables -A INPUT -j ACCEPT -p tcp --destination-port 22 -i eth0\' >> /tmp/firewall.sh'
  sudo 'echo \'sudo iptables -A INPUT -j DROP -p tcp -i eth0\' >> /tmp/firewall.sh'
  sudo 'chown root:root /tmp/firewall.sh'
  sudo 'chmod +x /tmp/firewall.sh'
  sudo 'mv /tmp/firewall.sh /etc/init.d/'
  sudo '/etc/init.d/firewall.sh'
  sudo 'update-rc.d firewall.sh defaults'
end

# nginx recipes

task :install_nginx do
  install_pcre
  version = 'nginx-0.5.12'
  set :src_package, {
    :file => version + '.tar.gz',    
    :dir => version,  
    :url => "http://sysoev.ru/nginx/#{version}.tar.gz",
    :unpack => "tar -xzvf #{version}.tar.gz;",
    :configure => './configure --sbin-path=/usr/local/sbin --with-http_ssl_module;',
    :make => 'make;',
    :install => 'make install;',
  }
  deprec.download_src(src_package, src_dir)
  deprec.install_from_src(src_package, src_dir)
  sudo 'wget http://notrocketsurgery.com/files/nginx -O /etc/init.d/nginx'
  sudo 'chmod 755 /etc/init.d/nginx'
  send(run_method, "update-rc.d nginx defaults")
end

task :configure_nginx do
  stop_nginx
  sudo "cp #{release_path}/config/nginx.conf /usr/local/nginx/conf/"
  start_nginx
end

task :install_pcre do
  apt.install({:base => ['libpcre3', 'libpcre3-dev']}, :stable)
end

task :start_nginx do
  sudo '/etc/init.d/nginx start'
end

task :restart_nginx do
  sudo '/etc/init.d/nginx restart'
end

task :stop_nginx do
  sudo '/etc/init.d/nginx stop'
end

task :create_database_yml do
  run "cp #{release_path}/config/database.yml.production #{release_path}/config/database.yml"  
end

# here is my section to tie this all together and make it as easy as three cap instructions to setup a new server
task :deploy_first_time do
  setup  
  deploy
  create_database_yml
  setup_mysql
  migrate
  configure_mongrel_cluster
  configure_nginx
  restart_mongrel_cluster
  start_nginx
end

# overwrite the deprec read_config task so that it grabs the right config
def read_config
  db_config = YAML.load_file('config/database.yml.production')
  set :db_user, db_config[rails_env]["username"]
  set :db_password, db_config[rails_env]["password"] 
  set :db_name, db_config[rails_env]["database"]
end
