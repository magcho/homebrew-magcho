cask 'ricoh-theta-app' do
  version '3.12.0'
  sha256 '820d1b6be34aa127a723c01ba5abf4247aeb2d58f80a3157f9b449eb0bff164b'

  url 'https://theta360.com/intl/support/download/pcapp/macosx'
  name 'RICOH THETA'
  homepage 'https://theta360.com/ja/'

  app 'RICOH THETA.app'

  uninstall pkgutil: 'com.ricoh.thetasphericalviewer'
end
