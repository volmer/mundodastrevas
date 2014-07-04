deploy_to = '/home/volmer/projects/mundodastrevas'
current = "#{deploy_to}/current"
shared = "#{deploy_to}/shared"
working_directory current
pid "#{shared}/tmp/pids/unicorn.pid"
stderr_path "#{shared}/log/unicorn.log"
stdout_path "#{shared}/log/unicorn.log"
preload_app true

# Port configuration
listen 5000
worker_processes 2

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
