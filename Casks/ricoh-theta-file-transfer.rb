cask 'ricoh-theta-file-transfer' do
  version '1.1.0'
  sha256 'e053cc516cf4328485c9200eea80d4372fde8755dc5e62093635f09c87310cf2'

  url 'https://theta360.com/intl/support/download/ftapp/macosx'
  name 'RICOH THETA File Transfer'
  homepage 'https://theta360.com/ja/'

  uninstall pkgutil: 'com.ricoh.RICOH-THETA-File-Transfer-for-Mac'
end
