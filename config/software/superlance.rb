name "superlance"
default_version "0.10"

dependency "python"
dependency "pip"

build do
  pip_call "install -I --install-option=\"--install-scripts=#{install_dir}/bin\" "\
           "#{name}==#{version}"
end
