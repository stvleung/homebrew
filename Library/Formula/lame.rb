require 'formula'

class Lame < Formula
  homepage 'http://lame.sourceforge.net/'
  url 'http://downloads.sourceforge.net/sourceforge/lame/lame-3.99.tar.gz'
  md5 '7abacd1d0a65a63733335786015626db'

  def options
  [
    ['--universal', 'Build universal binaries.']
  ]
  end

  def install
    args = ["--disable-debug",
            "--prefix=#{prefix}",
            "--enable-nasm"]

    if ARGV.build_universal?
      ENV.universal_binary 
      args << "--disable-dependency-tracking"
    end

    system "./configure", *args
    system "make install"
  end
end
