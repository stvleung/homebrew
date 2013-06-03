require 'formula'

class Fribidi < Formula
  homepage 'http://fribidi.org/'
  url 'http://fribidi.org/download/fribidi-0.19.2.tar.gz'
  sha1 '3889469d96dbca3d8522231672e14cca77de4d5e'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
