class Dotz < Formula
  desc "Backup and restore dotfiles"
  homepage "https://github.com/magcho/dotz/"
  url "https://github.com/magcho/dotz/releases/download/v0.2.1/dotz"
  sha256 "298e259a391705629e12edfa5fef5b107654d4b524d6af1c24191f929cc352c6"

  def install
    bin.install "dotz"
  end

  test do
    system "false"
  end
end
