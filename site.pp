include mymodule
exec {'test_docker':
  command => "/bin/bash -c 'docker rm $(docker ps -aq) -f' || true",
  unless => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
  refreshonly => true,
}