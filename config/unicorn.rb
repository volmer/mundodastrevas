require 'yaml'

#config = YAML.load_file('./config/config.yml')[Rails.env]['unicorn']

worker_processes 3
listen 5000 #'unix:/tmp/mundodastrevas.sock', backlog: 64
pid '/home/volmer/mundodastrevas.pid'

# Preload our app for more speed
preload_app true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

working_directory '/home/volmer/projects/mundodastrevas'

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
