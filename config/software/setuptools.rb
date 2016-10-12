#
# Copyright:: Copyright (c) 2013-2014 Chef Software, Inc.
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

name "setuptools"
default_version "28.3.0"

dependency "python"

relative_path "setuptools-#{version}"

if ohai['platform'] == 'windows'
  # FIXME: this file changes, which breaks the build. Let's put it on S3
  source :url => 'http://dd-agent-omnibus.s3.amazonaws.com/ez_setup.py',
         :md5 => 'ce2f1224d50f529b6093e3feb0799f09'

  build do
    command "\"#{windows_safe_path(install_dir)}\\embedded\\python.exe\" ez_setup.py "
  end
else
  source :url => "https://github.com/pypa/setuptools/archive/v#{version}.tar.gz",
         :sha256 => '726d5247151b1be1fcc6b64bdb22df029364a75a4856a464ad88be65d285ab46'
  build do
    ship_license "PSFL"
    command "#{install_dir}/embedded/bin/python bootstrap.py"
    command "#{install_dir}/embedded/bin/python setup.py install --prefix=#{install_dir}/embedded"
  end
end
