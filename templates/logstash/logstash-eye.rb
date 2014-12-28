Eye.application 'logstash' do
  working_dir '/opt/logstash'
  stdall '/var/log/eye/logstash-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
#  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :logstash do
    pid_file '/var/run/logstash-eye.pid'
    env 'JAVA_HOME' => '/usr/java/jdk1.8.0_25'
    start_command './bin/logstash -f /etc/logstash/logstash.conf'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
