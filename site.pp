include mymodule
exec {'test111_docker':
  command => "/bin/bash -c 'docker rm $(docker ps -aq) -f' || true",
  onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
}