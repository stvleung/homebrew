require 'formula'

class Yasm < Formula
  url 'http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz'
  homepage 'http://www.tortall.net/projects/yasm/'
  md5 '4cfc0686cf5350dd1305c4d905eb55a6'

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    if ARGV.build_universal?
      ENV.universal_binary
    end

    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    system "make install"
  end
end
