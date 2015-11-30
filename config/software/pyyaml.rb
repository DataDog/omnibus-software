name "pyyaml"
default_version "3.11"

dependency "python"
dependency "pip"

if ohai['platform'] == 'windows'
  dependency "libyaml-windows"
else
  dependency "libyaml"
end

build do
  ship_license "http://pyyaml.org/export/385/pyyaml/trunk/LICENSE"
  if ohai['platform'] == 'windows'
    pip_call "install -I --install-option=\"--install-scripts='"\
             "#{windows_safe_path(install_dir)}\\bin'\" #{name}==#{version}"
  else
    pip_call "install -I --install-option=\"--install-scripts=#{install_dir}/bin\" "\
             "#{name}==#{version}"
  end
end
