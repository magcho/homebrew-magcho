class Dotz < Formula
  desc "Backup and restore dotfiles"
  homepage "https://github.com/magcho/dotz/"
  lisence any_of: ["Apache-2.0"]

  # bottle do
  #   sha256 cellar: :any, big_sur: "a9fc119de12c5b14fadae13ad34a29eecaab288afa5aa3502781c0908f52a9d5"
  #   sha256 cellar: :any, monterey: "a9fc119de12c5b14fadae13ad34a29eecaab288afa5aa3502781c0908f52a9d5"
  #   sha256 cellar: :any, arm_bigsur: "ddcc5129b8b88b5b5977a963ef04373b6ae85211a791412de79afdf5e0f0e597"
  #   sha256 cellar: :any, arm64_monterey: "ddcc5129b8b88b5b5977a963ef04373b6ae85211a791412de79afdf5e0f0e597"
  # end

  depends_on "git"

  def install
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/magcho/dotz/releases/download/v0.2.3/dotz-arm64"
        sha256 "ddcc5129b8b88b5b5977a963ef04373b6ae85211a791412de79afdf5e0f0e597"
        bin.install "dotz-arm64"
      else
        url "https://github.com/magcho/dotz/releases/download/v0.2.3/dotz-amd64"
        sha256 "a9fc119de12c5b14fadae13ad34a29eecaab288afa5aa3502781c0908f52a9d5"
        bin.install "dotz-amd64"
      end
    end

  end

  test do
    system "false"
  end
end
