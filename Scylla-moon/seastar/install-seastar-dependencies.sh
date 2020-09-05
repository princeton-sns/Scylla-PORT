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

. /etc/os-release

if [ "$ID" = "ubuntu" ]; then
    if [ "$VERSION_ID" != "16.04" ]; then
        echo "Seastar: you are not working with Ubuntu16.04, please use the legacy scripts."
    fi
    apt-get install -y libaio-dev ragel libhwloc-dev libnuma-dev libpciaccess-dev libcrypto++-dev libboost-all-dev libxml2-dev xfslibs-dev libgnutls28-dev liblz4-dev libsctp-dev make libprotobuf-dev protobuf-compiler python3 libunwind8-dev systemtap-sdt-dev libtool cmake
else
    echo "Seastar: you are not working with Ubuntu! Exit!"
fi
