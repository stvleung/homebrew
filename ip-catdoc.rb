require 'formula'

class IpCatdoc < Formula
  homepage 'http://wagner.pp.ru/~vitus/software/catdoc/'
  #url 'http://ftp.wagner.pp.ru/pub/catdoc/catdoc-0.94.2.tar.gz'
  #sha1 '50ce9d7cb24ad6b10a856c9c24183e2b0a11ca04'

  head 'git@github.com:iParadigms/catdoc.git', :using => :git

  def install
    system "make", "-C", "src", "all-libs"
    lib.install "src/libcatdocall.a"
  end
end
