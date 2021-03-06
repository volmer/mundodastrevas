deploy_to = '/home/mundodastrevas/mundodastrevas'
current = "#{deploy_to}/current"
shared = "#{deploy_to}/shared"
working_directory current
pid "#{shared}/tmp/pids/unicorn.pid"
stderr_path "#{shared}/log/unicorn.log"
stdout_path "#{shared}/log/unicorn.log"

# Port configuration
listen '/tmp/unicorn.mundodastrevas.sock'
worker_processes 2

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 20

before_fork do |server, _worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH # rubocop:disable Lint/HandleExceptions
      # someone else did our job for us
    end
  end
end
