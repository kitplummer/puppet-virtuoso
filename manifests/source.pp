class virtuoso::source {
	### Get, build and install from source code
	package { "gcc": ensure => installed, },
	package { "gmake": ensure => installed, }
	package { "autoconf": ensure => installed, }
	package { "automake": ensure => installed, }
	package { "libtool": ensure => installed, }
	package { "flex": ensure => installed, }
	package { "bison": ensure => installed, }
	package { "gperf": ensure => installed, }
	package { "gawk": ensure => installed, }
	package { "m4": ensure => installed, }
	package { "make": ensure => installed, }
	package { "openssl-devel": ensure => installed, }
	package { "readline-devel": ensure => installed, }
	package { "wget": ensure => installed, }

	exec { "wget https://downloads.sourceforge.net/project/virtuoso/virtuoso/6.1.5/virtuoso-opensource-6.1.5.tar.gz?r=&ts=1340319716&use_mirror=voxel": 
		cwd => "/tmp",
		creates => "/tmp/virtuoso-opensource-6.1.5.tar.gz",
		path => ["/usr/bin", "/bin"]
	} ->
	exec { "tar zxvf virtuoso-opensource-6.1.5.tar.gz": 
		cwd => "/tmp",
		creates => "/tmp/virtuoso-opensource-6.1.5",
		path => ["/usr/bin/", "/bin"]
	} ->
	exec { "./autogen.sh":
		cwd => "/tmp/virtuoso-opensource-6.1.5",
		creates => "/tmp/virtuoso-opensource-6.1.5",
		path => ["/usr/bin/", "/bin"]
	} ->
	exec { "./configure":
		cwd => "/tmp/virtuoso-opensource-6.1.5",
		creates => "/tmp/virtuoso-opensource-6.1.5",
		path => ["/usr/bin/", "/bin"]
	} ->
	exec { "make && make install":
		cwd => "/tmp/virtuoso-opensource-6.1.5",
		creates => "/tmp/virtuoso-opensource-6.1.5",
		path => ["/usr/bin/", "/bin"]
	} ->
}