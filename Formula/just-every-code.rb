class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.191/code-aarch64-apple-darwin.tar.gz"
      sha256 "d1111db515bf1bb91a98d2c9c01eab6540e46259da735c5cad06b52f6435facf"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.191/code-x86_64-apple-darwin.tar.gz"
      sha256 "ce1bbd66b574e14fb5197d5b9d668ed7fb19bf2057400edf98d2367cfb2f2552"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.191/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "768307fc6b71a787f5156d30b4d22fbfa29ebed9818f6f8418fabea1a0313cce"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.191/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fd227876cf2cba8e99cfd0c2722ca776e04a6fbdcafca131b6342c48bd0163d5"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
