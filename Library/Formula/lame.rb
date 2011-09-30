require 'formula'

class Lame < Formula
  homepage 'http://lame.sourceforge.net/'
  url 'http://downloads.sourceforge.net/sourceforge/lame/lame-3.98.4.tar.gz'
  md5 '8e9866ad6b570c6c95c8cba48060473f'

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
