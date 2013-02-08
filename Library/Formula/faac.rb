require 'formula'

class Faac < Formula
  homepage 'http://www.audiocoding.com/faac.html'
  url 'http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz'
  sha1 'd00b023a3642f81bb1fb13d962a65079121396ee'

  option :universal

  def install
    ENV.universal_binary if ARGV.build_universal?

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
