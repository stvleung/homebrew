require 'formula'

class Libogg < Formula
  homepage 'http://www.xiph.org/ogg/'
  url 'http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz'
  md5 '0a7eb40b86ac050db3a789ab65fe21c2'

  head 'http://svn.xiph.org/trunk/ogg'

  if ARGV.build_head?
    depends_on "automake" => :build

    if MacOS.xcode_version >= "4.3"
      depends_on "libtool" => :build
      depends_on "autoconf" => :build
    end
  end

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    if ARGV.build_universal?
      ENV.universal_binary
    end

    system "./autogen.sh" if ARGV.build_head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize
    system "make install"
  end
end
