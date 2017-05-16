name 'jmxfetch'

dependency "maven"

env = {
  "JAVA_HOME" => "#{install_dir}/embedded/jdk",
}

local_jmx_repo = ENV['LOCAL_JMX_REPO']
if local_jmx_repo.nil? || local_jmx_repo.empty?
  source git: 'https://github.com/DataDog/jmxfetch.git'
else
  # For local development
  source path: ENV['LOCAL_JMX_REPO']
end

jmx_branch = ENV['JMX_BRANCH']
if jmx_branch.nil? || jmx_branch.empty?
  default_version 'master'
else
  default_version jmx_branch
end

relative_path 'jmxfetch'

build do
  ship_license 'https://raw.githubusercontent.com/DataDog/jmxfetch/master/LICENSE'

  command "#{install_dir}/embedded/maven/bin/mvn clean compile assembly:single", :env => env
  mkdir "#{install_dir}/agent/checks/libs"
  copy 'target/jmxfetch-*-jar-with-dependencies.jar', "#{install_dir}/agent/checks/libs"

end
