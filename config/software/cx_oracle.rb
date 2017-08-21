name "cx_Oracle"
default_version "6.0.1"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/oracle/python-cx_Oracle/master/LICENSE.txt"
  pip "install --install-option=\"--install-scripts="\
      "#{windows_safe_path(install_dir)}/bin\" "\
      "#{name}==#{version}"
end
