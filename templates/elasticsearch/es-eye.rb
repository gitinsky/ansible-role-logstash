Eye.application 'elasticsearch' do
  working_dir '/opt/elasticsearch'
  stdall '/var/log/eye/elasticsearch-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
#  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :elasticsearch do
    pid_file '/var/run/elasticsearch-eye.pid'
    env 'JAVA_HOME' => '/usr/java/jdk1.8.0_25'
    env 'ES_MIN_MEM' => '{{ elasticsearch_mem }}'
    env 'ES_MAX_MEM' => '{{ elasticsearch_mem }}'
    start_command './bin/elasticsearch'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
