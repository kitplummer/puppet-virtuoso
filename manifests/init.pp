class virtuoso(	$run = true ) {

	case $operatingsystem {
		ubuntu: {
			### Packages required
			package { "build-essential": ensure => installed, }
			package { "virtuoso-opensource": ensure => installed, }
			package { "virtuoso-vad-isparql": ensure => installed, }
			package { "virtuoso-vad-ods": ensure => installed, }
			package { "virtuoso-vad-tutorial": ensure => installed, }
			$hostingdir = '/usr/lib/virtuoso-opensource-6.1/hosting'
			$servicename = "virtuoso-opensource-6.1"
			$dbpath = '/var/lib/virtuoso-opensource-6.1/db/'
			$sharedir = '/usr/share/virtuoso-opensource-6.1/'
			$inipath = '/etc/virtuoso-opensource-6.1/'
			$defaultfile = '/etc/default/virtuoso-opensource-6.1'
			$version = '-6.1' 
		}
		default: {
			include virtuoso::source
			$servicename = "virtuoso"
			$topdir = "/usr/local/virtuoso-opensource/"
			$hostingdir = "${topdir}/lib/virtuoso/hosting/"
			$sharedir = "${topdir}/share/virtuoso/"
			$dbpath = "${topdir}/var/lib/virtuoso/db/"
			$inipath = "$dbpath"
			$defaultfile = "/etc/default/virtuoso-opensource"
			$version = ""
		}
	}

	file { "$defaultfile":
		owner => root,
		group => root,
		content => template("virtuoso/virtuoso-opensource.erb"),
		notify => $operatingsystem ? {
			ubuntu => Service[$servicename],
			default => Service[$servicename]
		},
		require => $operatingsystem ? {
			ubuntu => Package["virtuoso-opensource"],
			default => File["/etc/default"]
		}
	} 

	file { "${inipath}/virtuoso.ini":
		owner => root,
		group => root,
		content => template("virtuoso/virtuoso.ini.erb"),
		notify => $operatingsystem ? {
			ubuntu => Service[$servicename],
			default => Service[$servicename]
		},
		require => $operatingsystem ? {
			ubuntu => Package["virtuoso-opensource"],
			default => [Exec["make && make install"], File["/etc/virtuoso-opensource-6.1"]]
		}
	}

	service { $servicename:
		ensure => running,
		enable => true,
		hasrestart => false,
		hasstatus => false,
		require => File["/etc/init.d/$servicename"]
	}
}