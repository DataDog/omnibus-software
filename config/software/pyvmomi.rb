name "pyvmomi"
default_version "5.5.0.2014.1.1"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/vmware/pyvmomi/master/LICENSE.txt"
  if ohai['platform'] == 'windows'
    pip_call "install -I --install-option=\"--install-scripts='"\
             "#{windows_safe_path(install_dir)}/bin'\" #{name}==#{version}"
  else
    pip_call "install -I --install-option=\"--install-scripts=#{install_dir}/bin\" "\
             "#{name}==#{version}"
  end
end
