require 'formula'

class Libaacs < Formula
  homepage 'http://www.videolan.org/developers/libaacs.html'
  url 'ftp://ftp.videolan.org/pub/videolan/libaacs/0.6.0/libaacs-0.6.0.tar.bz2'
  sha1 'b0b82875c43f5bd8f28a249d0fc1eba48420b9e8'

  head do
    url 'git://git.videolan.org/libaacs.git'

    depends_on :autoconf => :build
    depends_on :automake => :build
    depends_on :libtool  => :build
  end

  depends_on 'bison' => :build
  depends_on 'libgcrypt'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    inreplace 'configure.ac', 'AM_CONFIG_HEADER', 'AC_CONFIG_HEADERS'
    system './bootstrap' if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
