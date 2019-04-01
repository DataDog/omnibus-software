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
default_version "7.64.1"

if ohai["platform"] != "windows"
  dependency "zlib"
  dependency "openssl"
  dependency "nghttp2"
  source :url => "https://curl.haxx.se/download/curl-#{version}.tar.gz",
         :sha256 => "432d3f466644b9416bc5b649d344116a753aeaa520c8beaf024a90cba9d3d35d"

  relative_path "curl-#{version}"

  build do
    ship_license "https://raw.githubusercontent.com/bagder/curl/master/COPYING"
    block do
      FileUtils.rm_rf(File.join(project_dir, "src/tool_hugehelp.c"))
    end

    # curl requires pkg-config that is shipped with the agent
    env = { "PATH" => "#{install_dir}/embedded/bin" + File::PATH_SEPARATOR + ENV["PATH"] }
    command ["./configure",
             "--prefix=#{install_dir}/embedded",
             "--disable-manual",
             "--disable-debug",
             "--enable-optimize",
             "--disable-ldap",
             "--disable-ldaps",
             "--disable-rtsp",
             "--enable-proxy",
             "--disable-dependency-tracking",
             "--enable-ipv6",
             "--without-libidn",
             "--without-gnutls",
             "--without-librtmp",
             "--without-libssh2",
             "--with-ssl=#{install_dir}/embedded",
             "--with-zlib=#{install_dir}/embedded",
             "--with-nghttp2=#{install_dir}/embedded"].join(" "), env: env

    command "make -j #{workers}", :env => { "LD_RUN_PATH" => "#{install_dir}/embedded/lib" }
    command "make install"
  end
else
    version "7.59.0"  # still needs to be bumped to >7.64.0

  # Compiling is hard... let's ship binaries instead : TODO: react according to platform
  source :url => "https://mirrors.kernel.org/sources.redhat.com/cygwin/x86_64/release/curl/libcurl4/libcurl4-#{version}-1.tar.xz",
         :sha256 => "3381a39ddf7a034b6c23b68863fa868437244c71619ec8e4c357cd45d08ac71d",
         :extract => :seven_zip

  relative_path "curl"

  build do
    ship_license "https://raw.githubusercontent.com/bagder/curl/master/COPYING"

    copy "cygcurl-4.dll", "\"#{windows_safe_path(install_dir)}\\embedded\\Lib\\cygcurl.dll\""
  end
end
