name "go"
default_version "1.4.2"

if ENV['PKG_TYPE'] == 'dmg'
	depends 'homebrew'
	build do
	   command "brew install go"
	end
end
