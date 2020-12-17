class mymodule {

        file { '/home/jenkins':
                ensure => directory,
                owner => 'jenkins',
        }

        file { '/home/jenkins/docker-compose.yml':
                mode => '0644',
                owner => 'jenkins',
                source => 'puppet:///modules/mymodule/docker-compose.yml',
        }

        file { '/home/jenkins/.env':
                mode => '0644',
                owner => 'jenkins',
                source => 'puppet:///modules/mymodule/.env',
        }

        file { '/home/jenkins/deployments.txt':
                mode => '0644',
                owner => 'jenkins',
                source => 'puppet:///modules/mymodule/deployments.txt',
				unless => "/bin/bash -c 'test -e /home/jenkins/deployments.txt'",
        }

}