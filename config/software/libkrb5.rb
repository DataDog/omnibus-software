name "libkrb5"
default_version "1.16.2"

dependency "autoconf"
dependency "automake"

version "1.16.2" do
  source url: "https://kerberos.org/dist/krb5/1.16/krb5-1.16.2.tar.gz"
  source sha256: "9f721e1fe593c219174740c71de514c7228a97d23eb7be7597b2ae14e487f027"
end

relative_path "krb5-#{version}/src"

reconf_env = { "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}" }

build do

  ship_license "https://raw.githubusercontent.com/krb5/krb5/master/NOTICE"

  patch :source => "aclocal-add-parameter-to-disable-keyutils-detection.patch"

  # after patching we need to recreate configure scripts w/ autoconf
  autoconf_cmd = ["autoreconf", "--install"].join(" ")
  command autoconf_cmd, :env => reconf_env

  cmd = ["./configure",
         "--disable-keyutils",
         "--prefix=#{install_dir}/embedded"].join(" ")
  env = {
    "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
    "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
    "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  }
  command cmd, :env => env
  command "make -j #{workers}", :env => { "LD_RUN_PATH" => "#{install_dir}/embedded/lib" }
  command "make install", :env => { "LD_RUN_PATH" => "#{install_dir}/embedded/lib" }
end
