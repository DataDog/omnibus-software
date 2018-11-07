name "libkrb5"
default_version "1.16.2"

version "1.16.2" do
  source url: "https://kerberos.org/dist/krb5/1.16/krb5-1.16.2.tar.gz"
  source sha256: "9f721e1fe593c219174740c71de514c7228a97d23eb7be7597b2ae14e487f027"
end

relative_path "krb5-#{version}/src"

build do
  cmd = ["./configure",
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
