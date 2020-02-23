class Dotz < Formula
  desc "backup and restore dotfiles"
  homepage "https://github.com/magcho/dotz/"
  url "https://github.com/magcho/dotz/releases/download/v#{version}/dotz"
  version "0.1.1"
  sha256 "c9f628993cb20abb0c1f8553602d7f87ed86f9b8b123b97bfd1a4b84585e7c56"

  def install
    bin.install "dotz"
  end

  test do
    system "false"
  end
end
