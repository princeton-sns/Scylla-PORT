#!/bin/bash
#
# This file is open source software, licensed to you under the terms
# of the Apache License, Version 2.0 (the "License").  See the NOTICE file
# distributed with this work for additional information regarding copyright
# ownership.  You may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

# Haonan: this scripts takes care of installing all necessary 3rd party dependencies, sudo this script
# It assumes Ubuntu16.04. For other OSes, good luck!

. /etc/os-release

#bash seastar/haonan_installs_for_seastar.bash
bash seastar/install-seastar-dependencies.sh 

if [ "$ID" = "ubuntu" ]; then
    # add scylla's package repo for release2.1 to apt-get
    echo "Adding /etc/apt/sources.list.d/scylla.list"
    echo "deb  [trusted=yes arch=amd64] http://s3.amazonaws.com/downloads.scylladb.com/deb/ubuntu/scylladb-2.1 xenial multiverse" > /etc/apt/sources.list.d/scylla.list
    echo "deb  [trusted=yes arch=amd64] http://downloads.scylladb.com/deb/3rdparty/xenial xenial scylladb/multiverse" > /etc/apt/sources.list.d/scylla-3rdparty.list
    apt-get -y install software-properties-common
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 17723034C56D4B19
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A874136B215467E8
    add-apt-repository ppa:scylladb/ppa -y
    apt -y update
    apt -y install libsystemd-dev python3-pyparsing libsnappy-dev libjsoncpp-dev libyaml-cpp-dev libthrift-dev antlr3-c++-dev antlr3 thrift-compiler scylla-server scylla-conf scylla-env scylla-jmx scylla-kernel-conf scylla-libisl018 scylla-libisl018-dev scylla-libthrift010 scylla-libthrift010-dev scylla-tools

    # install gcc-7, g++7, boost163
    apt-get -y install scylla-gcc72-gcc-7
    apt-get -y install scylla-gcc72-g++-7
    apt-get -y install scylla-libboost163-all-dev

    # install maven and java8
    apt-get -y install maven
    apt-get -y install openjdk-8-jdk 

    # install most recent ninja
    curdir=$(pwd)
    cd ../
    wget https://github.com/ninja-build/ninja/archive/v1.8.2.zip
    sudo apt -y install unzip
    unzip v1.8.2.zip
    cd ninja-1.8.2
    ./configure.py --bootstrap
    sudo cp ninja /usr/bin
    cd ../
    sudo rm v1.8.2.zip
    cd $curdir
    echo "ALL DEPS ARE INSTALLED!"
else
    echo "You are not working with Ubuntu, please use scylladb's legacy scripts!"
fi
