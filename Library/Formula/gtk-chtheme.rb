require 'formula'

class GtkChtheme < Formula
  homepage 'http://plasmasturm.org/code/gtk-chtheme/'
  url 'http://plasmasturm.org/code/gtk-chtheme/gtk-chtheme-0.3.1.tar.bz2'
  sha1 'dbea31f4092877e786fe040fae1374238fada94a'

  depends_on 'pkg-config' => :build
  depends_on 'gdk-pixbuf'
  depends_on 'gettext'
  depends_on 'glib'
  depends_on 'gtk+'
  depends_on 'pango'
  depends_on :x11

  def options
    [['--universal', 'Build universal binaries']]
  end

  def install
    # Unfortunately chtheme relies on some deprecated functionality
    # we need to disable errors for it to compile properly
    inreplace 'Makefile', '-DGTK_DISABLE_DEPRECATED', ''

    if ARGV.build_universal?
      ENV.universal_binary
      ENV.llvm
    end

    system "make", "PREFIX=#{prefix}", "install"
  end
end
