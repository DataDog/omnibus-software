name "pykerberos"
default_version "1.2.1"

dependency "python"
dependency "setuptools"
dependency "pip"
dependency "six"
dependency "libkrb5"

build do
  ship_license "https://raw.githubusercontent.com/apple/ccs-pykerberos/master/LICENSE.txt"

  env = {
    "CFLAGS" => "-I#{install_dir}/embedded/include",
    "CXXFLAGS" => "-I#{install_dir}/embedded/include",
    "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  }

  unless windows?
    pip "install pykerberos==#{version}", :env => env
  end
end
