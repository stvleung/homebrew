require 'formula'

class CsBuild < Formula
  homepage 'http://www.codesynthesis.com/projects/build'
  url 'http://www.codesynthesis.com/download/build/0.3/build-0.3.9.tar.bz2'
  sha1 '27541dca3d7d9a2d2a38433daec695acf93ed334'

  def install
    system "make", "install_prefix=#{prefix}", "install" 
  end
end
