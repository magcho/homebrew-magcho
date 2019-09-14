class Dotz < Formula
  desc "backup and restore dotfiles"
  homepage "https://github.com/magcho/dotz/"
  url "https://github.com/magcho/dotz/releases/download/v0.1.0/dotz"
  sha256 "feb059fbed52e606c3f1fabaa32fdbef713db7ccfc7902ae5502dd3dc3d92e7a"

  def install
    bin.install "dotz"
  end

  test do
    system "false"
  end
end
