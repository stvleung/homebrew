require 'formula'

class Libvorbis < Formula
  url 'http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.2.tar.bz2'
  md5 '798a4211221073c1409f26eac4567e8b'
  homepage 'http://vorbis.com'

  depends_on 'pkg-config' => :build
  depends_on 'libogg'

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    if ARGV.build_universal?
      ENV.universal_binary
    end

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
