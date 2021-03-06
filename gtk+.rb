require 'formula'

class Gtkx < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.22.tar.xz'
  sha256 'b114b6e9fb389bf3aa8a6d09576538f58dce740779653084046852fb4140ae7f'

  option :universal
  option 'quartz', 'Build quartz "variant"'

  depends_on 'pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'gdk-pixbuf'
  depends_on 'pango'
  depends_on 'jasper' => :optional
  depends_on 'atk'
  depends_on 'cairo'
  depends_on :x11 => '2.3.6' unless build.include? "quartz"

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-glibtest
      --disable-introspection
      --disable-visibility
    ]

    ENV.universal_binary if build.universal?

    if build.include? "quartz"
      args << '--with-gdktarget=quartz'
      args << '--without-x'
    end

    # Always prefer our cairo over XQuartz cairo
    cairo = Formula.factory('cairo')
    ENV['CAIRO_BACKEND_CFLAGS'] = "-I#{cairo.include}/cairo"
    ENV['CAIRO_BACKEND_LIBS'] = "-L#{cairo.lib} -lcairo"

    system "./configure", *args
    system "make install"
  end

  def test
    system "#{bin}/gtk-demo"
  end
end
