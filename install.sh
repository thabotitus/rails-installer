#! /bin/bash
# A script to automeate the process of installing Rails and all it's dependencies.

echo '=> Hi '$USER', beginning installation...'
sleep 2
echo '=> Installing dependencies...this may take awhile'

function update_cache {
	echo "-- Updating Cache..."
	`sudo apt-get update &> log/install.log`
	echo "-- Done updating cache..."
}

function install_dependencies {	
	echo "-- Installing dependencies..."
	`sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libqt4-dev &> log/install.log`
	echo "-- Done installing dependencies..."
}

function operating_system_details {
	OS=`uname -s`
	REV=`uname -r`
	MACH=`uname -m`
	echo $OS $REV $MACH
}

function current_ruby_version {
	RUBY_VERSION=`ruby -v &> log/install.log`

	if [[ $RUBY_VERSION == ""  ]]
	then
		echo "0"
	else
		echo $RUBY_VERSION
	fi
}

function current_rails_version {
	RAILS_VERSION=`rails -v &> log/install.log`
}

update_cache
install_dependencies