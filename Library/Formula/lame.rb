require 'formula'

class Lame < Formula
  homepage 'http://lame.sourceforge.net/'
  url 'http://downloads.sourceforge.net/sourceforge/lame/lame-3.99.1.tar.gz'
  md5 '2576a7368b5c90a87adc9de6b9f0628c'

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
