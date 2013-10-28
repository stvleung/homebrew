require 'formula'

class Cronolog < Formula
  homepage 'http://cronolog.org/'
  url 'http://cronolog.org/download/cronolog-1.6.2.tar.gz'
  sha1 '6422b7c5e87241eb31d76809a2e0eea77ae4c64e'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make install"
  end
end
