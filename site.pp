include mymodule
exec {'test_docker':
  command => "/bin/bash -c 'docker rm $(docker ps -aq) -f' || true",
  refreshonly => true,
}