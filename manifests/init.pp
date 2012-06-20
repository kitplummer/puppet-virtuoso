class virtuoso {

	### Fetch the lastest tarball of Virtuoso code base
	exec { "wget https://github.com/openlink/virtuoso-opensource/tarball/master -O virtuoso.tar":
		cwd => "/tmp",
		creates => "/tmp/virtuoso.tar",
		path => ["/usr/bin", "/bin"]
	} ->
	exec { "tar xvf virtuoso.tar; mv openlink-virtuoso-opensource* virtuoso":
		cwd => "/tmp",
		creates => "/tmp/virtuoso",
		path => ["/usr/bin", "/bin"]
	} ->

	### Packages required
	package { "build-essential":
		ensure => installed,
	} -> 

	package { "libssl-dev":
		ensure => installed,
	} ->

	package { "autoconf":
		ensure => installed,
	} ->

	package { "automake":
		ensure => installed,
	} ->

	package { "libtool":
		ensure => installed,
	} ->

	package { "bison":
		ensure => installed,
	} ->

	package { "flex":
		ensure => installed,
	} ->

	package { "gawk":
		ensure => installed,
	} ->

	package { "gperf":
		ensure => installed,
	} ->

	exec { "./autogen.sh"}

}