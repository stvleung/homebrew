require 'formula'

class X264 < Formula
  homepage 'http://www.videolan.org/developers/x264.html'
  url 'http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20120425-2245-stable.tar.bz2'
  sha1 '969e015e5df24091b5e62873808e6529a7f2fb7f'
  version 'r2189' # use version.sh to find this with brew install -i --HEAD x264

  head 'http://git.videolan.org/git/x264.git', :branch => 'stable'

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
