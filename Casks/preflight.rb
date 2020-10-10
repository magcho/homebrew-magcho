cask "preflight" do
  version "2.3.3"
  sha256 "9544ccb362f39850b764ba3fe844f6558e24b28f979392978ac521ac0b399741"

  url "http://www.kuwatec.co.jp/preflight/download/PrefLight#{version.delete(".")}.pkg"
  name "PrefLight"
  homepage "http://www.kuwatec.co.jp/preflight/jp/"

  pkg "PrefLight#{version.delete(".")}.pkg"

  uninstall pkgutil: "jp.co.kuwatec.PrefLight"
end
