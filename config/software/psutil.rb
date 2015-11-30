name "psutil"
default_version "2.2.1"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/giampaolo/psutil/master/LICENSE"
  if ohai['platform'] == 'windows'
    pip_call "install -I --install-option=\"--install-scripts="\
             "'#{install_dir}\\bin'\" #{name}==#{version}"
  else
    pip_call "install -I --install-option=\"--install-scripts=#{install_dir}/bin\""\
             "#{name}==#{version}"
  end
end
