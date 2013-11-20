require 'formula'

class LibfrontendElements < Formula
  homepage 'http://kolpackov.net/projects/libfrontend-elements'
  url 'ftp://kolpackov.net/pub/projects/libfrontend-elements/1.1/libfrontend-elements-1.1.4.tar.bz2'
  sha1 '690a559da6857d36aa7104ead003aa06d545fed3'

  depends_on 'cs-build' => :build

  def patches; DATA; end

  def install
    mkdir "#{name}-apple-darwin"
    system "make", "-C", "#{name}-apple-darwin", "-f", "../makefile"
    lib.install "#{name}-apple-darwin/frontend-elements/libfrontend-elements.so"
    Dir["frontend-elements/**/*.hxx", "frontend-elements/**/*.ixx", "frontend-elements/**/*.txx"].select {|f| (include+File.dirname(f)).install f}
  end
end

__END__
--- libfrontend-elements-1.1.4/frontend-elements/makefile	2010-01-01 03:19:31.000000000 -0800
+++ libfrontend-elements-1.1.4.new/frontend-elements/makefile	2013-11-20 10:14:48.000000000 -0800
@@ -32,7 +32,7 @@
 
 # Build.
 #
-$(frontend_elements.l): $(cxx_obj) $(cult.l)
+$(frontend_elements.l): $(cxx_obj)
 
 $(cxx_obj) $(cxx_od): $(frontend_elements.l.cpp-options)
 
