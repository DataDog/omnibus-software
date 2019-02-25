name "datadog-vsphere"
default_version "3.6.2"

dependency "python"
dependency "pip"

build do
  wheel_name = name.sub(/-/, "_")
  pip "install https://dd-integrations-core-wheels-build-stable.s3.amazonaws.com/targets/simple/#{name}/#{wheel_name}-#{version}-py2.py3-none-any.whl"
end
