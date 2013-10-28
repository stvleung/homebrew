require 'formula'

class Theora < Formula
  homepage 'http://www.theora.org/'
  url 'http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  sha1 '8dcaa8e61cd86eb1244467c0b64b9ddac04ae262'

  depends_on 'pkg-config' => :build
  depends_on 'libogg'
  depends_on 'libvorbis'

  option :universal

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
