class EmacsNg < Formula
  desc "New approach to Emacs"
  homepage "https://emacs-ng.github.io/emacs-ng/"
  url "https://github.com/emacs-ng/emacs-ng/archive/refs/tags/v0.0.6b6dfb3.tar.gz"
  version "0.0.6b6dfb3"
  sha256 "afd3bf705f503cc44dfbbc571ff15cf3e33f4fdc757c0122507f00e1b6d30f52"
  license "GPL-3.0-or-later"

  depends_on "autoconf" => :build
  depends_on "gcc" => :build
  depends_on "gnu-sed" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "rustup-init" => :build
  depends_on "texinfo" => :build
  depends_on "zlib" => :build
  depends_on "gnutls"
  depends_on "jansson"
  depends_on "libgccjit"
  depends_on "librsvg"
  depends_on "little-cms2"
  depends_on "automake" => :build

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp
      --infodir=#{info}/emacs
      --prefix=#{prefix}
      --with-gnutls
      --with-json
      --with-native-compilation
      --with-modules
      --with-gnutls
      --with-xml2
      --without-x
      --without-dbus
      --without-imagemagick
      --without-selinux
    ]

    gcc_ver = Formula["gcc"].any_installed_version
    gcc_ver_major = gcc_ver.major
    gcc_lib="#{HOMEBREW_PREFIX}/lib/gcc/#{gcc_ver_major}"

    ENV.append "CFLAGS", "-I#{Formula["gcc"].include}"
    ENV.append "CFLAGS", "-I#{Formula["libgccjit"].include}"
    ENV.append "CFLAGS", "-I#{Formula["jansson"].include}"

    ENV.append "LDFLAGS", "-L#{gcc_lib}"
    ENV.append "LDFLAGS", "-I#{Formula["gcc"].include}"
    ENV.append "LDFLAGS", "-I#{Formula["libgccjit"].include}"
    ENV.append "LDFLAGS", "-I#{Formula["jansson"].include}"

    system "#{Formula["rustup-init"].bin}/rustup-init", "-y", "--no-modify-path"
    ENV.prepend_path "PATH", HOMEBREW_CACHE/"cargo_cache/bin"

    # system "exit 1", exception: false
    begin
      system "./autogen.sh" # 必ず１回目はexit 1で落ちる
    rescue
      system "./autogen.sh" # ２回実行する必要がある
    end

    system "./configure", *args
    system "make"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test emacs-ng`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
