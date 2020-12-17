include mymodule

exec {'list_docker_containers':
  command => "/bin/bash -c 'docker ps -a'",
  onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
  notify  => Exec['stop_docker_containers'],
}

exec {'stop_docker_containers':
  command => "/bin/bash -c 'docker stop $(docker ps -aq) -f || true'",
  onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
  refreshonly => true,
  notify  => Exec['clear_docker_containers'],
}

exec {'clear_docker_containers':
  command => "/bin/bash -c 'docker rm $(docker ps -aq) -f || true'",
  onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
  refreshonly => true,
  notify  => Exec['clear_docker_images'],
}

exec {'clear_docker_images':
  command => "/bin/bash -c 'docker rmi $(docker images -q) || true'",
  onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
  refreshonly => true,
  notify  => Exec['pull_docker_images'],
}

exec {'pull_docker_images':
  command => "/bin/bash -c 'docker-compose pull'",
  cwd => "/home/jenkins/",
  onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
  refreshonly => true,
  notify  => Exec['up_docker_images'],
}

exec {'up_docker_images':
  command => "/bin/bash -c 'docker-compose up -d --no-build'",
  cwd => "/home/jenkins/",
  onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
  refreshonly => true,
  notify  => Exec['remove_flag_file'],
}

exec {'remove_flag_file':
	command => "/bin/bash -c 'rm /home/jenkins/deployments.txt'",
	onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
	refreshonly => true,
}