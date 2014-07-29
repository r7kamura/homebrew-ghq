require 'formula'

HOMEBREW_GHQ_VERSION='0.4'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  url "https://github.com/r7kamura/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"
  sha1 '527c6bfa4f4fc03b19cb5795ad4736cecfd6763f'

  version HOMEBREW_GHQ_VERSION
  head 'https://github.com/motemen/ghq', :using => :git, :branch => 'master'

  if build.head?
    depends_on 'go' => :build
    depends_on 'hg' => :build
  end

  def install
    if build.head?
      gopath = buildpath/'.go'

      ( gopath/'src/github.com/motemen/ghq' ).make_relative_symlink buildpath

      ENV['GOPATH'] = gopath
      system 'make', 'BUILD_FLAGS=-o ghq'
    end

    bin.install 'ghq_darwin_amd64/ghq'
  end
end
