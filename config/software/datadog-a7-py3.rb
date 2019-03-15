name "datadog-a7-py3"
default_version "0.0.5"

dependency "pip-py3"

build do
  ship_license "https://raw.githubusercontent.com/DataDog/datadog-checks-shared/master/LICENSE"
  py3pip "install --install-option=\"--install-scripts="\
      "#{windows_safe_path(install_dir)}/bin\" "\
      "#{name}==#{version} "\
      "configparser==3.5.0" # this pins a dependency of pylint->datadog-a7, later versions (up to v3.7.1) are broken.
                            # TODO: all deps should be pinned.
end
