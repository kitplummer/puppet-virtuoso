class virtuoso {

	### Packages required
	package { "build-essential":
		ensure => installed,
	}

	package { "virtuoso-opensource":
		ensure => installed,
	}

	package { "virtuoso-vad-isparql":
		ensure => installed,
	}

	package { "virtuoso-vad-ods":
		ensure => installed,
	}

	package { "virtuoso-vad-tutorial":
		ensure => installed,
	}

	## I really want augeas to work, resorting to sed.
	# package { "rubygems":
	# 	ensure => installed
	# } ->
	# package { "augeas-tools":
	# 	ensure => installed,
	# } ->
	# package { "libaugeas-dev":
	# 	ensure => installed,
	# } ->
	# package { "libaugeas-ruby":
	# 	ensure => installed,
	# }

	# # In order to run we have to edit the default config
	# augeas { "virtuoso-opensource-6.1":
	# 	context => "/etc/default/virtuoso-opensource-6.1",
	# 	changes => ["set RUN yes",],
	# }

	exec { "run=yes":
		command => 'sed "s/RUN=no/RUN=yes/" /etc/default/virtuoso-opensource-6.1 > /tmp/tmp.txt && mv /tmp/tmp.txt /etc/default/virtuoso-opensource-6.1',
		path => ["/usr/bin", "/bin"],
		cwd => "/tmp",
		require => Package["virtuoso-opensource"],
		onlyif => 'grep RUN=yes /etc/default/virtuoso-opensource-6.1',
	}

	service { "virtuoso-opensource-6.1":
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => [Package["virtuoso-opensource"],Exec["run=yes"]],
	}
}