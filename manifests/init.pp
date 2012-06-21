class virtuoso(
	$inipath = '/etc/virtuoso-opensource-6.1/', 
	$dbpath = '/var/lib/virtuoso-opensource-6.1/',
	$run = true ) {

	case $operatingsystem {
		ubuntu: {
			### Packages required
			package { "build-essential": ensure => installed, }
			package { "virtuoso-opensource": ensure => installed, }
			package { "virtuoso-vad-isparql": ensure => installed, }
			package { "virtuoso-vad-ods": ensure => installed, }
			package { "virtuoso-vad-tutorial": ensure => installed, }
			$servicename = "virtuoso-opensource-6.1"
		}
		default: {
			include virtuoso::source
			$servicename = "virtuoso"
		}
	}

	file { "/etc/default/virtuoso-opensource-6.1":
		owner => root,
		group => root,
		content => template("virtuoso/virtuoso-opensource.erb"),
		notify => $operatingsystem ? {
			ubuntu => Service[$servicename],
		}
		require => $operatingsystem ? {
			ubuntu => Package["virtuoso-opensource"],
		}
	} 

	file { "${inipath}/virtuoso.ini":
		owner => root,
		group => root,
		content => template("virtuoso/virtuoso.ini.erb"),
		notify => $operatingsystem ? {
			ubuntu => Service[$servicename],
		}
		require => $operatingsystem ? {
			ubuntu => Package["virtuoso-opensource"],
		}
	}

	service { $servicename:
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
	}
}