#
# Copyright 2013-2014 Chef Software, Inc.
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

# Oracle doesn't distribute JDK builds for ARM, only JDK
# builds. Since we do no want to ship a larger package with a
# different layout, we just pick the 'jdk' folder inside the jdk.
name "jdk"
default_version "8u91"

dependency "rsync"

whitelist_file "jdk"

license_warning = "By including the JDK, you accept the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, which can be found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html"
license_cookie = "gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"

version "8u91" do

  if ohai['kernel']['machine'] =~ /x86_64/
      # https://www.oracle.com/webfolder/s/digest/8u91checksum.html
      file = "jdk-8u91-linux-x64.tar.gz"
      md5 = "3f3d7d0cd70bfe0feab382ed4b0e45c0"

  else
      # https://www.oracle.com/webfolder/s/digest/8u91checksum.html
      file = "jdk-8u91-linux-i586.tar.gz"
      md5 = "f18cbe901f2c77630f1e301cea32b259"
  end

  source url: "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/#{file}",
         md5: md5,
         cookie: license_cookie,
         warning: license_warning,
         unsafe: true

  relative_path "jdk1.8.0_91"
end

version "8u112" do

  if ohai['kernel']['machine'] =~ /x86_64/
      # https://www.oracle.com/webfolder/s/digest/8u112checksum.html
      file = "jdk-8u112-linux-x64.tar.gz"
      md5 = "de9b7a90f0f5a13cfcaa3b01451d0337"

  else
      # https://www.oracle.com/webfolder/s/digest/8u112checksum.html
      file = "jdk-8u112-linux-i586.tar.gz"
      md5 = "66ccf8e7c28969d56863034d030134bf"
  end

  source url: "http://download.oracle.com/otn-pub/java/jdk/8u112-b15/#{file}",
         md5: md5,
         cookie: license_cookie,
         warning: license_warning,
         unsafe: true

  relative_path "jdk1.8.0_91"
end

build do
  mkdir "#{install_dir}/embedded/jdk"
  command "#{install_dir}/embedded/bin/rsync -a . #{install_dir}/embedded/jdk"
end
