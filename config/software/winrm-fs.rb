#
# Copyright 2016 Chef Software, Inc.
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

name "winrm-fs"
default_version "master"

source git: "https://github.com/WinRb/winrm-fs.git"

dependency "ruby"
dependency "rubygems"
dependency "bundler"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  bundle "install --without development", env: env

  gem "build winrm-fs.gemspec", env: env
  gem "install winrm-fs-*.gem" \
      " --no-ri --no-rdoc", env: env
end