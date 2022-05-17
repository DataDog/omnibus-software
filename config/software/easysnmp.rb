name "easysnmp"
default_version "0.2.4"

dependency "libnetsnmp"
dependency "python"
dependency "pip"

build do
  license "https://github.com/fgimian/easysnmp/blob/master/LICENSE"
  command "#{install_dir}/embedded/bin/pip install -I --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}"
end
