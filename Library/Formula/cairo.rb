require 'formula'

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url 'http://www.cairographics.org/releases/cairo-1.12.2.tar.xz'
  sha1 'bc2ee50690575f16dab33af42a2e6cdc6451e3f9'

  depends_on 'pkg-config' => :build
  depends_on 'pixman'

  keg_only :provided_by_osx,
            "The Cairo provided by Leopard is too old for newer software to link against."

  def options
    [
      ['--universal', 'Build universal binaries'],
      ['--quartz', 'Build quartz "variant"']
    ]
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]
    args << '--enable-xcb' unless MacOS.leopard?

    if ARGV.include? "--quartz"
      args << '--without-x'
      args << '--disable-xlib'
      args << '--disable-xcb'
      args << '--enable-quartz'
      args << '--enable-quartz-font'
      args << '--enable-quartz-image'
    else
      args << '--with-x'
    end

    ENV.universal_binary if ARGV.build_universal?
    ENV.llvm
    system "./configure", *args
    system "make install"
  end
end
