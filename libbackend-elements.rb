require 'formula'

class LibbackendElements < Formula
  homepage 'http://kolpackov.net/projects/libbackend-elements'
  url 'ftp://kolpackov.net/pub/projects/libbackend-elements/1.7/libbackend-elements-1.7.2.tar.bz2'
  sha1 '6658cbbe22c4a71c8db88fb4c3db690c1695fd1a'

  depends_on 'cs-build' => :build

  def install
    mkdir "#{name}-apple-darwin"
    system "make", "-C", "#{name}-apple-darwin", "-f", "../makefile"
    Dir["backend-elements/**/*.hxx", "backend-elements/**/*.txx"].select {|f| (include+File.dirname(f)).install f}
  end
end
