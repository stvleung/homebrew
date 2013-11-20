require 'formula'

class Libcult < Formula
  homepage 'http://kolpackov.net/projects/libcult'
  url 'ftp://kolpackov.net/pub/projects/libcult/1.4/libcult-1.4.6.tar.bz2'
  sha1 'a2a440951693e62e458f42532da332e31bdfa041'

  depends_on 'cs-build' => :build

  def patches; DATA; end

  def install
    mkdir "#{name}-apple-darwin"
    system "make", "-C", "#{name}-apple-darwin", "-f", "../makefile"
    lib.install "#{name}-apple-darwin/cult/libcult.so"
    Dir["cult/**/*.hxx", "cult/**/*.ixx", "cult/**/*.txx"].select {|f| (include+File.dirname(f)).install f}
    (include+'cult').install "#{name}-apple-darwin/cult/config.hxx"
  end
end

__END__
--- a/makefile	2010-01-01 03:11:55.000000000 -0800
+++ b/makefile	2013-11-19 17:50:11.000000000 -0800
@@ -8,8 +8,7 @@
 default   := $(out_base)/
 clean     := $(out_base)/.clean
 
-$(default): $(out_base)/cult/ $(out_base)/examples/
+$(default): $(out_base)/cult/
 $(clean): $(out_base)/cult/.clean $(out_base)/examples/.clean
 
 $(call import,$(src_base)/cult/makefile)
-$(call import,$(src_base)/examples/makefile)
