require 'formula'

class Lame < Formula
  homepage 'http://lame.sourceforge.net/'
  url 'http://downloads.sourceforge.net/sourceforge/lame/lame-3.99.3.tar.gz'
  md5 '5ad31e33e70455eb3a7b79a5dd934fce'

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
