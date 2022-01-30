cask "preflight" do
  version "2.4.6"
  sha256 "fb05b5f7feb11623a168b77bf81bd8723332e2cf2029660b774603e47e9ac160"

  url "http://www.kuwatec.co.jp/preflight/download/PrefLight#{version.delete(".")}.pkg"
  name "PrefLight"
  homepage "http://www.kuwatec.co.jp/preflight/jp/"

  pkg "PrefLight#{version.delete(".")}.pkg"

  uninstall pkgutil: "jp.co.kuwatec.PrefLight"
end
