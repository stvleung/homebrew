require 'formula'

class Yasm < Formula
  homepage 'http://yasm.tortall.net/'
  url 'http://tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz'
  sha256 '768ffab457b90a20a6d895c39749adb547c1b7cb5c108e84b151a838a23ccf31'

  head 'https://github.com/yasm/yasm.git'

  def options
    [['--enable-python', 'Enable Python bindings support.']]
  end

  if ARGV.build_head?
    depends_on 'gettext'
    depends_on :automake
  end

  depends_on 'Cython' => :python if ARGV.include? '--enable-python'

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    args = %W[--prefix=#{prefix} --disable-debug]

    if ARGV.build_universal?
      ENV.universal_binary
      args << '--disable-dependency-tracking'
    end

    if ARGV.include? '--enable-python'
      args << '--enable-python'
      args << '--enable-python-bindings'
    end

    # Avoid "ld: library not found for -lcrt1.10.6.o" on Xcode without CLT
    ENV['LIBS'] = ENV.ldflags
    ENV['INCLUDES'] = ENV.cppflags
    system './autogen.sh' if ARGV.build_head?
    system './configure', *args
    system 'make install'
  end

  def caveats
    if ARGV.include? '--enable-python' then <<-EOS.undent
      Python bindings installed to:
        #{HOMEBREW_PREFIX}/lib/#{which_python}/site-packages

      For non-homebrew Python, you need to amend your PYTHONPATH like so:
        export PYTHONPATH=#{HOMEBREW_PREFIX}/lib/#{which_python}/site-packages:$PYTHONPATH
      EOS
    end
  end

  def which_python
    'python' + `python -c 'import sys;print(sys.version[:3])'`.strip
  end
end
