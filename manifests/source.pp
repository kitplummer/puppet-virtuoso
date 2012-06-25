class virtuoso::source ($binpath = "/usr/local/virtuoso-opensource/bin") {
	### Get, build and install from source code

	package { "gcc": ensure => installed, } ->
	package { "autoconf": ensure => installed, } ->
	package { "automake": ensure => installed, } ->
	package { "libtool": ensure => installed, } ->
	package { "flex": ensure => installed, } ->
	package { "bison": ensure => installed, } ->
	package { "gperf": ensure => installed, } ->
	package { "gawk": ensure => installed, } ->
	package { "m4": ensure => installed, } ->
	package { "make": ensure => installed, } ->
	package { "openssl-devel": ensure => installed, } ->
	package { "readline-devel": ensure => installed, } ->
	package { "wget": ensure => installed, } ->
	package { "python-devel": ensure => installed, } ->
	package { "unixODBC-devel": ensure => installed, } ->

	exec { "wget https://downloads.sourceforge.net/project/virtuoso/virtuoso/6.1.5/virtuoso-opensource-6.1.5.tar.gz": 
		cwd => "/tmp",
		creates => "/tmp/virtuoso-opensource-6.1.5.tar.gz",
		path => ["/usr/bin", "/bin"],
		timeout => 600, # 4 minutes
	} ->
	exec { "tar zxvf virtuoso-opensource-6.1.5.tar.gz": 
		cwd => "/tmp",
		creates => "/tmp/virtuoso-opensource-6.1.5",
		path => ["/usr/bin/", "/bin"]
	} ->
	exec { "./autogen.sh":
		command => "./autogen.sh",
		cwd => "/tmp/virtuoso-opensource-6.1.5",
		creates => "/tmp/virtuoso-opensource-6.1.5/configure",
		path => ["/usr/bin/", "/bin"]
	} ->
	exec { "./configure --with-readline":
	    command => "/tmp/virtuoso-opensource-6.1.5/configure --with-readline",
		cwd => "/tmp/virtuoso-opensource-6.1.5",
		creates => "/tmp/virtuoso-opensource-6.1.5/Makefile",
		path => ["/usr/bin/", "/bin", "."]
	} ->
	exec { "make && make install":
		cwd => "/tmp/virtuoso-opensource-6.1.5",
		creates => "/usr/local/virtuoso-opensource",
		path => ["/usr/bin/", "/bin"],
		timeout => 600, # 10 minutes
	} ->
	file { "/etc/default":
		ensure => directory,
	} ->
	file { "/etc/virtuoso-opensource-6.1": 
		ensure => directory,
	} ->

	file { "/etc/init.d/virtuoso":
		owner => root,
		group => root,
		mode => 0755,
		content => template("virtuoso/virtuoso.erb"),
	}
}