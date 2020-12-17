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
		
}