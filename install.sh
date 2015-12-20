#! /bin/bash
# A script to automate the process of installing Rails and all it's dependencies.
# V 0.0.1

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

function rvm_exists {
	RVM=`rvm -v`
	if [[ $RVM == "" ]]
	then
		return false
	else
		return true
	fi
}

function current_rails_version {
	RAILS_VERSION=`rails -v &> log/install.log`

}
function update_cache {
	echo "-- Updating Cache..."
	`sudo apt-get update &> log/install.log`
	echo "-- Done updating cache..."
}

function install_dependencies {	
	echo "-- Installing dependencies...this may take a while"
	`sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libqt4-dev &> log/install.log`
	echo "-- Done installing dependencies..."
}

function install_rvm {
	echo "-- Installing RVM dependencies..."
	`sudo apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev &> log/rvm.log`
	echo "-- Installing RVM..."
	`gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
	`curl -L https://get.rvm.io | bash -s stable &> log/rvm.log`
	source `~/.rvm/scripts/rvm`
	echo "-- Done installing RVM..."
}

function install_ruby {
	echo "-- Installing RUBY..."
	if [[ rvm_exists == true ]] 
	then	
		`rvm install 2.2.3 &> log/ruby.log`
		echo "-- Done installing RUBY..."
	else
		echo "RVM wasn't installed properly..Check log/ruby.log for details"
		exit 1
	fi
}

function run_installation {
	echo '=> Hi '$USER', beginning installation...'	
	sleep 2
	update_cache
	install_dependencies
	install_rvm
	install_ruby
}

run_installation