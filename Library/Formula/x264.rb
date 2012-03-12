require 'formula'

class X264 < Formula
  url 'http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20120111-2245.tar.bz2'
  homepage 'http://www.videolan.org/developers/x264.html'
  md5 'a4a18f7172e50b6cecc1c65324a03c9e'
  version 'r2245'

  head 'git://git.videolan.org/x264.git'

  depends_on 'yasm' => :build

  def options
    [
      ["--10-bit", "Make a 10-bit x264. (default: 8-bit)"],
      ["--universal", "Build for both 32 & 64 bit Intel."],
    ]
  end

  def install
    args = ["--prefix=#{prefix}", "--enable-shared"]
    args << "--bit-depth=10" if ARGV.include?('--10-bit')

    if ARGV.build_universal?
      args << "--disable-asm"
      system "./configure", *args
      system "make .depend"
      ENV.universal_binary
    end

    system "./configure", *args
    system "touch .depend"

    if MacOS.prefer_64_bit? && !ARGV.build_universal?
      inreplace 'config.mak' do |s|
        soflags = s.get_make_var 'SOFLAGS'
        s.change_make_var! 'SOFLAGS', soflags.gsub(' -Wl,-read_only_relocs,suppress', '')
      end
    end

    system "make install"
  end
end
