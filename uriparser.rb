require 'formula'

class Uriparser < Formula
  homepage 'http://uriparser.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/uriparser/Sources/0.7.9/uriparser-0.7.9.tar.bz2'
  sha1 'c02d1db3c4e132863b6fc4e4f5e08cec535089d1'

  depends_on 'pkg-config' => :build
  depends_on 'cpptest'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-doc"
    system "make check"
    system "make install"
  end
end
