class Dotz < Formula
  desc "backup and restore dotfiles"
  homepage "https://github.com/magcho/dotz/"
  version "0.1.1"
  url "https://github.com/magcho/dotz/releases/download/v#{version}/dotz"
  sha256 "09339c041f1dccb5dbc756d81d777159cc2720e4644b10e678704d717e7715fc"

  def install
    bin.install "dotz"
  end

  test do
    system "false"
  end
end
