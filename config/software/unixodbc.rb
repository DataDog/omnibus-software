name "unixodbc"
default_version "2.3.10"

version("2.3.7") { source sha256: "45f169ba1f454a72b8fcbb82abd832630a3bf93baa84731cf2949f449e1e3e77" }
version("2.3.9") { source sha256: "52833eac3d681c8b0c9a5a65f2ebd745b3a964f208fc748f977e44015a31b207" }
version("2.3.10") { source sha256: "783c8fe0a26fa6406ad951236f7bfc6555dec63c82d7d1c6d171db392208a15f" }

source url: "https://www.unixodbc.org/unixODBC-#{version}.tar.gz"

relative_path "unixODBC-#{version}"

build do
  license "LGPL-2.1"
  license_file "./COPYING"

  env = with_standard_compiler_flags(with_embedded_path)

  configure_args = [
    "--disable-readline",
    "--prefix=#{install_dir}/embedded",
    "--with-included-ltdl",
    "--enable-ltdl-install",
  ]

  configure_command = configure_args.unshift("./configure").join(" ")

  command configure_command, env: env, in_msys_bash: true
  command "make -j #{workers}", env: env
  command "make install", env: env

  # Remove the sample (empty) files unixodbc adds, otherwise they will replace
  # any user-added configuration on upgrade.
  delete "#{install_dir}/embedded/etc/odbc.ini"
  delete "#{install_dir}/embedded/etc/odbcinst.ini"

  # Add a section to the README
  block do
    File.open(File.expand_path(File.join(install_dir, "/embedded/etc/README.md")), "a") do |f|
      f.puts <<~EOF
          ## unixODBC

          To add unixODBC data sources that can be used by the Agent embedded environment,
          add `odbc.ini` and `odbcinst.ini` files to this folder, containing the data sources'
          configuration.

      EOF
    end
  end
end
