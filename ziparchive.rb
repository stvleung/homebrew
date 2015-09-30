require 'formula'

class Ziparchive < Formula
  homepage 'http://www.artpol-software.com'
  url 'http://www.artpol-software.com/Downloads/ziparchive_src.zip'
  sha1 '1ee983a856d52546225e16c6d4ef0ad116871506'

  version "4.6.2"

  depends_on :autoconf => :build
  depends_on :automake => :build
  depends_on :libtool  => :build

  def patches; DATA; end

  def install
  	chdir "ZipArchive"
  	system "sh ./autogen.sh"
  	system "./configure", "--prefix=#{prefix}"
    system "make", "install" 
  end
end

__END__
diff -Naur ziparchive_orig/ZipArchive/Makefile.am ziparchive/ZipArchive/Makefile.am
--- ziparchive_orig/ZipArchive/Makefile.am	1969-12-31 16:00:00.000000000 -0800
+++ ziparchive/ZipArchive/Makefile.am	2013-10-28 18:12:55.000000000 -0700
@@ -0,0 +1,45 @@
+MAINTAINERCLEANFILES = INSTALL \
+			Makefile.in \
+			aclocal.m4 \
+			config.guess \
+			config.h.in \
+			config.h.in~ \
+			stamp-h.in \
+			config.sub \
+			configure \
+			install-sh \
+			missing \
+			mkinstalldirs \
+			ltmain.sh \
+			ltconfig \
+			compile \
+			depcomp
+
+AM_CXXFLAGS = -Wall
+
+lib_LTLIBRARIES = libziparch.la
+
+libziparch_la_LDFLAGS = -release $(VERSION)
+libziparch_la_LIBADD = -lz
+
+libziparch_la_SOURCES = \
+ZipArchive.cpp ZipAutoBuffer.cpp ZipCentralDir.cpp \
+ZipCompressor.cpp BaseLibCompressor.cpp Bzip2Compressor.cpp \
+DeflateCompressor.cpp ZipCompatibility.cpp ZipException.cpp ZipFile_stl.cpp ZipFileHeader.cpp \
+ZipMemFile.cpp ZipPathComponent_lnx.cpp ZipPlatformComm.cpp ZipPlatform_lnx.cpp \
+ZipStorage.cpp ZipString.cpp ZipExtraData.cpp ZipExtraField.cpp \
+DirEnumerator.cpp FileFilter.cpp Wildcard.cpp \
+ZipCryptograph.cpp ZipCrc32Cryptograph.cpp \
+Aes.cpp Hmac.cpp RandomPool.cpp ZipAesCryptograph.cpp Sha1.cpp
+
+libziparchdir = $(includedir)/ZipArchive
+
+libziparch_HEADERS = \
+BitFlag.h DirEnumerator.h _features.h FileFilter.h FileInfo.h _platform.h \
+stdafx.h std_stl.h Wildcard.h ZipAbstractFile.h ZipArchive.h ZipAutoBuffer.h \
+ZipBaseException.h ZipCallback.h ZipCallbackProvider.h ZipCentralDir.h \
+ZipCollections.h ZipCollections_stl.h ZipCompatibility.h ZipCompressor.h \
+ZipCryptograph.h ZipException.h ZipExport.h ZipExtraData.h ZipExtraField.h \
+ZipFile.h ZipFileHeader.h ZipFile_stl.h ZipMemFile.h ZipMutex.h ZipMutex_lnx.h \
+ZipPathComponent.h ZipPlatform.h ZipSplitNamesHandler.h ZipStorage.h \
+ZipString.h ZipString_stl.h ZipStringStoreSettings.h
diff -Naur ziparchive_orig/ZipArchive/ZipArchive.pc.in ziparchive/ZipArchive/ZipArchive.pc.in
--- ziparchive_orig/ZipArchive/ZipArchive.pc.in	1969-12-31 16:00:00.000000000 -0800
+++ ziparchive/ZipArchive/ZipArchive.pc.in	2013-10-28 18:12:55.000000000 -0700
@@ -0,0 +1,12 @@
+prefix=@prefix@
+exec_prefix=@exec_prefix@
+libdir=@libdir@
+includedir=@includedir@/ZipArchive
+
+Name: ZipArchive
+Description: ZipArchive library
+Version: @VERSION@
+
+Requires:
+Libs: -L${libdir} -lziparch
+Cflags: -I${includedir}
diff -Naur ziparchive_orig/ZipArchive/ZipFileHeader.cpp ziparchive/ZipArchive/ZipFileHeader.cpp
--- ziparhive_orig/ZipArchive/ZipFileHeader.cpp.orig	2015-09-30 11:41:00.000000000 -0700
+++ ziparhive/ZipArchive/ZipFileHeader.cpp	2015-09-30 11:41:37.000000000 -0700
@@ -932,31 +932,7 @@
 
 DWORD CZipFileHeader::GetSystemAttr()
 {
-	if (ZipCompatibility::IsPlatformSupported(GetSystemCompatibility()))
-	{
-		DWORD uAttr = GetSystemCompatibility() == ZipCompatibility::zcUnix ? (m_uExternalAttr >> 16) : (m_uExternalAttr & 0xFFFF);
-		DWORD uConvertedAttr = ZipCompatibility::ConvertToSystem(uAttr, GetSystemCompatibility(), ZipPlatform::GetSystemID());
-		// some zip files seem to report size greater than 0 for folders
-		if ((m_uComprSize == 0 || m_uExternalAttr == 0) && !ZipPlatform::IsDirectory(uConvertedAttr) && CZipPathComponent::HasEndingSeparator(GetFileName()))
-		{
-			// can happen, a folder can have attributes set and no dir attribute (Python modules)
-			// TODO: [postponed] fix and cache after reading from central dir, but avoid calling GetFileName() there to keep lazy name conversion
-			// We convert again as uConvertedAttr were treated as a file during ZipCompatibility::ConvertToSystem above
-			DWORD uSystemDirAttributes = ZipCompatibility::ConvertToSystem(ZipPlatform::GetDefaultDirAttributes(), ZipPlatform::GetSystemID(), GetSystemCompatibility());
-			return ZipCompatibility::ConvertToSystem(uAttr | uSystemDirAttributes, GetSystemCompatibility(), ZipPlatform::GetSystemID());
-		}
-		else
-		{                                      
-#ifdef _ZIP_SYSTEM_LINUX
-			// converting from Windows attributes may create a not readable linux directory
-			if (GetSystemCompatibility() != ZipCompatibility::zcUnix && ZipPlatform::IsDirectory(uConvertedAttr))
-				return ZipPlatform::GetDefaultDirAttributes();
-#endif
-			return uConvertedAttr;
-		}
-	}
-	else
-		return CZipPathComponent::HasEndingSeparator(GetFileName()) ? ZipPlatform::GetDefaultDirAttributes() : ZipPlatform::GetDefaultAttributes();
+	return CZipPathComponent::HasEndingSeparator(GetFileName()) ? ZipPlatform::GetDefaultDirAttributes() : ZipPlatform::GetDefaultAttributes();
 }
 
 bool CZipFileHeader::SetSystemAttr(DWORD uAttr)
diff -Naur ziparchive_orig/ZipArchive/_platform.h ziparchive/ZipArchive/_platform.h
--- ziparchive_orig/ZipArchive/_platform.h	2013-02-25 16:29:56.000000000 -0800
+++ ziparchive/ZipArchive/_platform.h	2013-10-28 18:12:51.000000000 -0700
@@ -29,7 +29,7 @@
 /************************************ BLOCK START ***********************************/
 
 //#define _ZIP_IMPL_MFC
-//#define _ZIP_SYSTEM_LINUX
+#define _ZIP_SYSTEM_LINUX
 
 // simplified endianess detection
 #ifdef __APPLE__
diff -Naur ziparchive_orig/ZipArchive/autogen.sh ziparchive/ZipArchive/autogen.sh
--- ziparchive_orig/ZipArchive/autogen.sh	1969-12-31 16:00:00.000000000 -0800
+++ ziparchive/ZipArchive/autogen.sh	2013-10-28 18:14:52.000000000 -0700
@@ -0,0 +1,12 @@
+#! /bin/sh
+
+if [ "$USER" = "root" ]; then
+  echo "You cannot do this as "$USER" please use a normal user account"
+  exit
+fi
+
+glibtoolize --copy
+aclocal
+autoheader
+automake --add-missing --copy --foreign
+autoconf
diff -Naur ziparchive_orig/ZipArchive/configure.ac ziparchive/ZipArchive/configure.ac
--- ziparchive_orig/ZipArchive/configure.ac	1969-12-31 16:00:00.000000000 -0800
+++ ziparchive/ZipArchive/configure.ac	2013-10-28 18:14:47.000000000 -0700
@@ -0,0 +1,21 @@
+## Bootstrap autoconf/automake
+AC_PREREQ(2.59)
+AC_INIT([ZipArchive], [4.5.0], [])
+AC_CANONICAL_TARGET
+AC_CONFIG_SRCDIR([configure.ac])
+AM_INIT_AUTOMAKE
+AM_CONFIG_HEADER([config.h])
+
+## Checks for programs.
+AC_PROG_CC
+AC_PROG_CXX
+AM_PROG_CC_STDC
+AC_PROG_INSTALL
+AC_PROG_MAKE_SET
+AC_PROG_LIBTOOL
+
+# Produce output
+AC_CONFIG_FILES([Makefile ZipArchive.pc])
+AC_OUTPUT
+
+echo "Type 'make' to compile"
