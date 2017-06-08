#!/usr/bin/env ruby
# encoding: utf-8

name "pycurl"
default_version "7.43.0"

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
  version "7.43.0"
  wheel_name = "pycurl-7.43.0-cp27-none-win_amd64.whl"
  wheel_md5 = "66c232b0da1e8314cf3794c5644ff49f"

  source :url => "https://s3.amazonaws.com/dd-agent-omnibus/#{wheel_name}",
         :md5 => wheel_md5

  relative_path "pycurl-#{version}"

  build do
    pip "install #{wheel_name}"

    # Delete these lines as soon as we have upgraded to pycurl > 7.43.0
    # This is a custom built pycurl
    python_lib_path = File.join(install_dir, "embedded", "Lib", "site-packages")
    command "powershell.exe -Command wget -outfile pycurl.pyd https://s3.amazonaws.com/dd-agent-omnibus/pycurl.pyd"
    pycurl_sha256 = "f5 b6 9c b1 85 d4 ff dc 75 5d 46 a6 e9 32 80 d5 77 ae b6 06 2f 29 d3 0e 4b d3 08 7c 2b f0 a4 1d"
    command "CertUtil -hashfile pycurl.pyd SHA256 | grep '#{pycurl_sha256}' && mv pycurl.pyd #{python_lib_path}"

  end
end
