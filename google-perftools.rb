require 'formula'

class GooglePerftools < Formula
  # TODO rename to gperftools when renames are supported
  homepage 'http://code.google.com/p/gperftools/'
  url 'http://gperftools.googlecode.com/files/gperftools-2.1.tar.gz'
  sha1 'b799b99d9f021988bbc931db1c21b2f94826d4f0'

  fails_with :llvm do
    build 2326
    cause "Segfault during linking"
  end

  def patches; DATA; end

  def install
    ENV.append_to_cflags '-D_XOPEN_SOURCE'
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end

__END__
diff --git a/src/static_vars.cc b/src/static_vars.cc
index 013027d..81e8a79 100644
--- a/src/static_vars.cc
+++ b/src/static_vars.cc
@@ -32,6 +32,7 @@
 // Author: Ken Ashcraft <opensource@google.com>
 
 #include "static_vars.h"
+#include <pthread.h>                    // for pthread_atfork
 #include <stddef.h>                     // for NULL
 #include <new>                          // for operator new
 #include "internal_logging.h"  // for CHECK_CONDITION
