require 'formula'

class Lame < Formula
  homepage 'http://lame.sourceforge.net/'
  url 'http://downloads.sourceforge.net/sourceforge/lame/lame-3.99.4.tar.gz'
  md5 'e54d7847bfd01f18d56c07e65147d75a'

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
