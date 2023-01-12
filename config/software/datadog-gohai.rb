name "datadog-gohai"
default_version "agent-v5"

always_build true

env = {
  "GOPATH" => "#{Omnibus::Config.cache_dir}/src/#{name}",
}

if ohai["platform_family"] == "mac_os_x"
  gobin = "/usr/local/bin/go"
elsif ohai["platform"] == "windows"
  gobin = "C:/Go/bin/go"
else
  env["GOROOT"] = "/usr/local/go"
  gobin = "/usr/local/go/bin/go"
end

build do
  ship_license "https://raw.githubusercontent.com/DataDog/gohai/#{version}/LICENSE"
  ship_license "https://raw.githubusercontent.com/DataDog/gohai/#{version}/THIRD_PARTY_LICENSES.md"

  # Checkout gohai
  command "#{gobin} get -d github.com/DataDog/gohai", :env => env # No need to pull latest from remote with `-u` here since the next command checks out and pulls latest
  command "git checkout #{version} && git pull", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/#{name}/src/github.com/DataDog/gohai"

  # Checkout correct version for gohai's deps
  command "git checkout v2.0.0", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/#{name}/src/github.com/shirou/gopsutil"
  command "git checkout v2.6", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/#{name}/src/github.com/cihub/seelog"
  # Windows depends on the registry, go get that.
  if ohai["platform"] == "windows"
    command "#{gobin} get -d golang.org/x/sys/windows/registry", :env => env
    command "git checkout 5f54ce54270977bfbd7353a37e64c13d6bd6c9c9", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/#{name}/src/golang.org/x/sys/windows/registry"
  end

  # Build gohai
  command "cd #{env['GOPATH']}/src/github.com/DataDog/gohai && #{gobin} run make.go #{gobin} && mv gohai #{install_dir}/bin/gohai", :env => env
end
