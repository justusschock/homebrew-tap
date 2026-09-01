class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.176/code-aarch64-apple-darwin.tar.gz"
      sha256 "87fed0800015d4fdb3fd1fbc9008e9884c8fd7516248c1a53b2be5974a830a53"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.176/code-x86_64-apple-darwin.tar.gz"
      sha256 "96f6736785bce0871844fac902b21d6b7186cefa6da1d09acb0f7b9be7617d2d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.176/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dd53f4b6f87305567e9fc7476576e86fb6cb04fb82790f2e1658eaf43cb64bb8"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.176/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8a31ad28191ce679b207fd09beb82eee7da5129a4e6f2a701502cac96485be2b"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
