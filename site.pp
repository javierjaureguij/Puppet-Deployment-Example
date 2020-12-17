include mymodule
exec {'test_docker':
  command => "/bin/bash -c 'docker rm $(docker ps -aq) -f'",
  unless => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'"
}

exec {'remove_flag_file':
	command => "/bin/bash -c 'rm /home/jenkins/deployments.txt'",
	onlyif => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
	require => Exec['test_docker'],
}