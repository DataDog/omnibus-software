name "jmxfetch"

if windows?
  default_version "0.26.8"
else
  jmx_version = ENV["JMX_VERSION"]
  if jmx_version.nil? || jmx_version.empty?
    raise "Please specify a JMX_VERSION env variable to build."
  else
    default_version jmx_version
  end
end

version "0.26.8" do
  source sha256: "8b4a8f8f8357fcb63c7cd60f10afd2fa4df0cafc18b173bfb0d02efce41cdf70"
end

version "0.26.7" do
  source sha256: "4e3b13d1660dc3d1168bfdaf16c3dd8c2f984c63521dc32133f6291ff6a828fe"
end

version "0.26.6" do
  source sha256: "1e80b6b05229c1720ddd6b8974892458b85048a64a3a0f3b58ea58d2e23016f4"
end

jar_dir = "#{install_dir}/agent/checks/libs"
agent_version = ENV["AGENT_VERSION"] || "5"
if agent_version[0] == "6"
  jar_dir = "#{install_dir}/bin/agent/dist/jmx"
end

source :url => "https://dl.bintray.com/datadog/datadog-maven/com/datadoghq/jmxfetch/#{version}/jmxfetch-#{version}-jar-with-dependencies.jar"

relative_path "jmxfetch"

build do
  ship_license "https://raw.githubusercontent.com/DataDog/jmxfetch/master/LICENSE"
  mkdir jar_dir
  copy "jmxfetch-#{version}-jar-with-dependencies.jar", jar_dir
  block { File.chmod(0644, "#{jar_dir}/jmxfetch-#{version}-jar-with-dependencies.jar") }
end
