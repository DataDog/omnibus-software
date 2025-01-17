#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "curl"
default_version "8.11.1"

dependency "zlib"
dependency "openssl3"
dependency "nghttp2"
source url:    "https://curl.haxx.se/download/curl-#{version}.tar.gz",
       sha256: "a889ac9dbba3644271bd9d1302b5c22a088893719b72be3487bc3d401e5c4e80"

relative_path "curl-#{version}"

build do
  license "Curl"
  license_file "https://raw.githubusercontent.com/bagder/curl/master/COPYING"
  env = with_standard_compiler_flags(with_embedded_path)

  configure_options = [
           "--disable-manual",
           "--disable-debug",
           "--enable-optimize",
           "--disable-static",
           "--enable-proxy",
           "--disable-dependency-tracking",
           "--enable-ipv6",
           "--without-libidn",
           "--without-gnutls",
           "--without-librtmp",
           "--without-libssh2",
           "--without-libpsl",
           "--with-ssl",
           "--with-zlib",
           "--with-nghttp2",
           "--disable-docs",
           "--disable-libcurl-option",
           "--disable-versioned-symbols",
           # Disable support for protocols we don't need
           "--disable-dict",
           "--disable-file",
           "--disable-ftp",
           "--disable-ftps",
           "--disable-gopher",
           "--disable-imap",
           "--disable-imaps",
           "--disable-ipfs",
           "--disable-ipns",
           "--disable-ldap",
           "--disable-ldaps",
           "--disable-mqtt",
           "--disable-pop3",
           "--disable-pop3s",
           "--disable-rtsp",
           "--disable-smb",
           "--disable-smbs",
           "--disable-smtp",
           "--disable-smtps",
           "--disable-telnet",
           "--disable-tftp",
           "--disable-ws",
           "--disable-wss",
  ]
  configure(*configure_options, env: env)

  command "make -j #{workers}", env: env
  command "make install"
end
