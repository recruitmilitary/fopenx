# unicorn_rails -c /home/deploy/public_html/board/current/config/unicorn.rb -E production -D

ENV['HOME'] ||= '/home/deploy'

rails_env = ENV['RAILS_ENV'] || 'production'
deploy_to = '/home/deploy/public_html/fopenx'
working_directory = deploy_to
shared_path = deploy_to
shared_bundler_gems_path = "#{shared_path}/bundle"

worker_processes 4

# Load rails into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 60 seconds
timeout 30

# Listen on a Unix data socket
listen "#{working_directory}/tmp/sockets/unicorn.sock", :backlog => 2048

stdout_path "#{working_directory}/log/unicorn.log"
stderr_path "#{working_directory}/log/unicorn-error.log"

##
# REE
# http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end
