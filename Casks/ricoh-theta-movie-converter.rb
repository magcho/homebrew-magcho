cask 'ricoh-theta-movie-converter' do
  version '2.0.1'
  sha256 '8567ac63975802e2b84a56387038cb516f44ffddb91239eb90d4db51cacda9e6'

  url 'https://theta360.com/ja/support/download/mcapp/macosx'
  name 'RICOH THETA'
  homepage 'https://theta360.com/ja/'

  app 'RICOH THETA Movie Converter.app'

  uninstall pkgutil: 'com.ricoh.RICOH-THETA-Movie-Converter'
end
