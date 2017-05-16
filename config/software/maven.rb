name "maven"
default_version "3.3.9"

dependency "rsync"
dependency "jdk"

version "3.3.9" do
  # https://www.oracle.com/webfolder/s/digest/8u91checksum.html
  file = "apache-maven-3.3.9-bin.tar.gz"
  md5 = "516923b3955b6035ba6b0a5b031fbd8b"

  source url: "http://www.gtlib.gatech.edu/pub/apache/maven/maven-3/3.3.9/binaries/#{file}",
         md5: md5,
         unsafe: true

  relative_path "apache-maven-3.3.9"
end

build do
  mkdir "#{install_dir}/embedded/maven"

  command "#{install_dir}/embedded/bin/rsync -a . #{install_dir}/embedded/maven"
end
