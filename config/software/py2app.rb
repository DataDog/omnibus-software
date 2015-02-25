name 'py2app'

default_version '0.9.0'

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}"
}

build do
  command "#{install_dir}/embedded/bin/pip install -U py2app", :env => env
  # Required during the app build
  command "cp /System/Library/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib"\
          " #{install_dir}/embedded/lib/libpython2.7.dylib"
end
