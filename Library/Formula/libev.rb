require 'formula'

class Libev < Formula
  homepage 'http://software.schmorp.de/pkg/libev.html'
  url 'http://dist.schmorp.de/libev/Attic/libev-4.11.tar.gz'
  sha1 'e7752a518742c0f8086a8005aa7efcc4dcf02ed9'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make install"

    # Remove compatibility header to prevent conflict with libevent
    (include/"event.h").unlink
  end
end
