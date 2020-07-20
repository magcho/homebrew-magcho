class Dotz < Formula
  desc "Backup and restore dotfiles"
  homepage "https://github.com/magcho/dotz/"
  url "https://github.com/magcho/dotz/releases/download/v0.2.0/dotz"
  sha256 "496c0b129cf430974e1327b0cbca51818c9d3cf02e40514c3b845aed46655819"

  def install
    bin.install "dotz"
  end

  test do
    system "false"
  end
end
