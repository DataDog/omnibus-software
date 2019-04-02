#!/usr/bin/env ruby
# encoding: utf-8

name "pycurl"
default_version "7.43.0.2"

dependency "python"
dependency "pip"

if ohai["platform"] != "windows"
  dependency "curl"
  dependency "gdbm" if ohai["platform"] == "mac_os_x" || ohai["platform"] == "freebsd" || ohai["platform"] == "aix"
  dependency "libgcc" if ohai["platform"] == "solaris2" && Omnibus.config.solaris_compiler == "gcc"

  build do
    ship_license "https://raw.githubusercontent.com/pycurl/pycurl/master/COPYING-MIT"
    build_env = {
      "PATH" => "/#{install_dir}/embedded/bin:#{ENV['PATH']}",
      "ARCHFLAGS" => "-arch x86_64",
    }
    command "#{install_dir}/embedded/bin/pip install #{name}==#{version}", :env => build_env
  end
else

  build do
    ship_license "https://raw.githubusercontent.com/pycurl/pycurl/master/COPYING-MIT"
    pip "install #{name}==#{version}"
  end
end
