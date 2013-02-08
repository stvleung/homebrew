require 'formula'

class Rtmpdump < Formula
  homepage 'http://rtmpdump.mplayerhq.hu'
  url 'http://rtmpdump.mplayerhq.hu/download/rtmpdump-2.4.tar.gz'
  sha1 '975f8c79788d1f9fcc66f572509f0203982b17ac'

  head 'git://git.ffmpeg.org/rtmpdump'

  depends_on 'openssl' if MacOS.version == :leopard

  option :universal

  fails_with :llvm do
    build '2336'
    cause "Crashes at runtime"
  end

  def install
    ENV.universal_binary if ARGV.build_universal?

    ENV.deparallelize
    system "make", "CC=#{ENV.cc}",
                   "XCFLAGS=#{ENV.cflags}",
                   "XLDFLAGS=#{ENV.ldflags}",
                   "MANDIR=#{man}",
                   "SYS=darwin",
                   "prefix=#{prefix}",
                   "install"
  end
end
