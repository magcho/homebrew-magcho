class Dotz < Formula
  desc "Backup and restore dotfiles"
  homepage "https://github.com/magcho/dotz/"
  url "https://github.com/magcho/dotz/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "77a724f8fb311af20580b0e7c4b30bede6e51aef0bc3f267fe4f48ec9b06de32"
  license any_of: ["Apache-2.0"]
  depends_on "git"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magcho/dotz/releases/download/v0.2.3/dotz-arm64"
      sha256 "ddcc5129b8b88b5b5977a963ef04373b6ae85211a791412de79afdf5e0f0e597"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magcho/dotz/releases/download/v0.2.3/dotz-amd64"
      sha256 "a9fc119de12c5b14fadae13ad34a29eecaab288afa5aa3502781c0908f52a9d5"
    end
  end

  def install
    bin.install "dotz-arm64" if Hardware::CPU.arm?
    bin.install "dotz-amd64" if Hardware::CPU.intel?
  end
end
