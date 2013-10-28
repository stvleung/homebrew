require 'formula'

class RegisteredDomainLibs < Formula
  homepage 'http://www.dkim-reputation.org/regdom-libs/'
  #url 'http://www.dkim-reputation.org/regdom-lib-downloads/registered-domain-libs-20131017.tgz'
  #sha1 '79c7cb6e6b0b4a3fc81c4ab3a552c98fef31af75'

  head 'git@github.com:iParadigms/regdom.git', :using => :git

  def install
    system "make", "-C", "C", "libregdom.so"
    lib.install 'C/libregdom.so'
    include.install 'C/dkim-regdom.h'
    include.install 'C/tld-canon.h'
  end
end
