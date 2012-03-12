require 'formula'

class Wget < Formula
  homepage 'http://www.gnu.org/software/wget/'
  url 'http://ftpmirror.gnu.org/wget/wget-1.13.4.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/wget/wget-1.13.4.tar.bz2'
  md5 '12115c3750a4d92f9c6ac62bac372e85'

  depends_on "openssl" if MacOS.leopard?
  depends_on "libidn" if ARGV.include? "--enable-iri"

  def options
    [
      ["--enable-iri", "Enable iri support."],
      ['--universal', 'Build universal binaries.']
    ]
  end

  def install
    args = ["--disable-debug",
            "--prefix=#{prefix}",
            "--sysconfdir=#{etc}",
            "--with-ssl=openssl"]

    if ARGV.build_universal?
      ENV.universal_binary
      args << "--disable-dependency-tracking"
    end

    args << "--disable-iri" unless ARGV.include? "--enable-iri"

    system "./configure", *args
    system "make install"
  end

  def test
    system "#{bin}/wget -O - www.google.com"
  end
end
