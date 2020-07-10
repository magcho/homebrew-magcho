cask 'preflight' do
  version '2.3.2'
  sha256 'ea80563c4ce6fa0e655afafedfa0dcabf954c403823311502c1c5565e844c0d0'

  url "http://www.kuwatec.co.jp/preflight/download/PrefLight#{version.delete('.')}.pkg"
  name 'PrefLight'
  homepage 'http://www.kuwatec.co.jp/preflight/jp/'

  pkg "PrefLight#{version.delete('.')}.pkg"

  uninstall pkgutil: 'jp.co.kuwatec.PrefLight'
end
