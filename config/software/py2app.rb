name 'py2app'

default_version '0.9.0'

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}"
}

build do
  command "#{install_dir}/embedded/bin/pip install -U py2app", :env => env
end
