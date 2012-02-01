require 'formula'

class OpencoreAmr < Formula
  url 'http://downloads.sourceforge.net/opencore-amr/opencore-amr-0.1.2.tar.gz'
  homepage 'http://opencore-amr.sourceforge.net/'
  md5 '8e8b8b253eb046340ff7b6bf7a6ccd3e'

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    if ARGV.build_universal?
      ENV.universal_binary
    end

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
