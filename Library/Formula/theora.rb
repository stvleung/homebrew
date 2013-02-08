require 'formula'

class Theora < Formula
  homepage 'http://www.theora.org/'
  url 'http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  sha1 '8dcaa8e61cd86eb1244467c0b64b9ddac04ae262'

  depends_on 'pkg-config' => :build
  depends_on 'libogg'
  depends_on 'libvorbis'

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    if ARGV.build_universal?
      ENV.universal_binary
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
