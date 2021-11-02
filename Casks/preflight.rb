cask "preflight" do
  version "2.4.3"
  sha256 "7f75e69aedeea91be91812a1cd5296f7188c2185abcdd0931c9f22fcb4d05fdb"

  url "http://www.kuwatec.co.jp/preflight/download/PrefLight#{version.delete(".")}.pkg"
  name "PrefLight"
  homepage "http://www.kuwatec.co.jp/preflight/jp/"

  pkg "PrefLight#{version.delete(".")}.pkg"

  uninstall pkgutil: "jp.co.kuwatec.PrefLight"
end
