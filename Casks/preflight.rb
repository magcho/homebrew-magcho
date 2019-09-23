cask 'preflight' do
  version '2.2.1'
  sha256 '389eecfa60e0c9e0d19214369b976b63567cc5373e24f8f10862af473d3b2265'

  url "http://www.kuwatec.co.jp/preflight/download/PrefLight#{version.delete('.')}.pkg"
  name 'PrefLight'
  homepage 'http://www.kuwatec.co.jp/preflight/jp/'

  pkg "PrefLight#{version.delete('.')}.pkg"

  uninstall pkgutil: "jp.co.kuwatec.PrefLight"
end
