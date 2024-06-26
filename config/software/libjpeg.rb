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

name "libjpeg"
default_version "8d"

source url: "https://www.ijg.org/files/jpegsrc.v8d.tar.gz",
       sha256: "fdc4d4c11338ad028a7d23fb53f5bb9354671392a67fb1b52e0c32a7121891f8"

relative_path "jpeg-8d"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
}

build do
  command "./configure --prefix=#{install_dir}/embedded --enable-shared --enable-static", env: configure_env
  mkdir "#{install_dir}/embedded/man/man1"
  command "make -j #{workers}", env: { "LD_RUN_PATH" => "#{install_dir}/embedded/lib" }
  command "make install"
  delete "#{install_dir}/embedded/man"
end
