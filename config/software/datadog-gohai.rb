name "datadog-gohai"
default_version "last-stable"

if ohai['platform'] == 'windows'
  gobin = 'go'

  build do
    ship_license "https://raw.githubusercontent.com/DataDog/gohai/master/LICENSE"
    command "#{gobin} get github.com/DataDog/gohai"
    command "cd #{ENV['GOPATH']}\\path\\src\\github.com\\DataDog\\gohai & #{gobin} build -o "\
            "\"#{windows_safe_path(install_dir)}\\bin\\gohai\" gohai.go"
  end
else
  env = {
    "GOROOT" => "/usr/local/go",
    "GOPATH" => "#{Omnibus::Config.cache_dir}/src/#{name}"
  }

  if ohai['platform_family'] == 'mac_os_x'
    env.delete "GOROOT"
    gobin = "/usr/local/bin/go"
  else
    gobin = "/usr/local/go/bin/go"
  end

  build do
     ship_license "https://raw.githubusercontent.com/DataDog/gohai/master/LICENSE"
     command "#{gobin} get -d -u github.com/DataDog/gohai", :env => env
     command "git checkout #{version} && git pull", :env => env, :cwd => "#{env['GOPATH']}/src/github.com/DataDog/gohai"
     command "#{gobin} build -o #{install_dir}/bin/gohai $GOPATH/src/github.com/DataDog/gohai/gohai.go", :env => env
  end
end
