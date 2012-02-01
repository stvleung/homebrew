require 'formula'

class Faac < Formula
  url 'http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz'
  md5 '80763728d392c7d789cde25614c878f6'
  homepage 'http://www.audiocoding.com/faac.html'

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
