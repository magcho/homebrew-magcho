cask 'preflight' do
  version '2.2.4'
  sha256 '052600202d5f7ed5d69186683ad1aca700a2f00ab1676e00a19da99167cc8e78'

  url "http://www.kuwatec.co.jp/preflight/download/PrefLight#{version.delete('.')}.pkg"
  name 'PrefLight'
  homepage 'http://www.kuwatec.co.jp/preflight/jp/'

  pkg "PrefLight#{version.delete('.')}.pkg"

  uninstall pkgutil: "jp.co.kuwatec.PrefLight"
end
