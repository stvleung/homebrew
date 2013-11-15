require 'formula'

class CsBuild < Formula
  homepage 'http://www.codesynthesis.com/projects/build'
  url 'http://www.codesynthesis.com/download/build/0.3/build-0.3.9.tar.bz2'
  sha1 '27541dca3d7d9a2d2a38433daec695acf93ed334'

  head 'git://scm.codesynthesis.com/build/build.git'

  def patches; DATA; end

  def install
    system "make", "install_prefix=#{prefix}", "install" 
  end
end

__END__
diff --git a/build/c/gnu/o-l.make b/build/c/gnu/o-l.make
index 5c93f0a..a059a86 100644
--- a/build/c/gnu/o-l.make
+++ b/build/c/gnu/o-l.make
@@ -64,7 +64,7 @@ ifeq ($(mingw),n)
 #
        $(call message,ld  $@,$(ld) -shared \
 $(c_extra_options) $(ld_options) $(c_ld_extra_options) \
--o $(@D)/lib$(basename $(@F)).so -Wl$(comma_)-soname=lib$(basename $(@F)).so \
+-o $(@D)/lib$(basename $(@F)).so -Wl$(comma_)-install_name,lib$(basename $(@F)).so \
 $(foreach f,$^,$(if $(patsubst %.l,,$f),$f,$(call expand-l,$f))) $(c_extra_libs))
        $(call message,,echo "$(@D)/lib$(basename $(@F)).so" >$@)
        $(call message,,echo "rpath:$(@D)" >>$@)
diff --git a/build/cxx/gnu/o-l.make b/build/cxx/gnu/o-l.make
index ea3e1d1..7e75b6d 100644
--- a/build/cxx/gnu/o-l.make
+++ b/build/cxx/gnu/o-l.make
@@ -65,7 +65,7 @@ ifeq ($(mingw),n)
 #
        $(call message,ld  $@,$(ld) -shared \
 $(cxx_extra_options) $(ld_options) $(cxx_ld_extra_options) \
--o $(@D)/lib$(basename $(@F)).so -Wl$(comma_)-soname=lib$(basename $(@F)).so \
+-o $(@D)/lib$(basename $(@F)).so -Wl$(comma_)-install_name,lib$(basename $(@F)).so \
 $(foreach f,$^,$(if $(patsubst %.l,,$f),$f,$(call expand-l,$f))) $(cxx_extra_libs))
        $(call message,,echo "$(@D)/lib$(basename $(@F)).so" >$@)
        $(call message,,echo "rpath:$(@D)" >>$@)

