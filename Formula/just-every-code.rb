class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.184/code-aarch64-apple-darwin.tar.gz"
      sha256 "e5a940a1ac6d533ac8e3656e105a8dee6a38c41cb5914710418e49f43f40e2c0"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.184/code-x86_64-apple-darwin.tar.gz"
      sha256 "e6da5811432514d159008d9568e20b70510b08670380889a9a023d220c3b3c37"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.184/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9d062f986b553d1fe046acea0b81ee28a00b86e98fad4ea9af6e50e980b75b77"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.184/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "969a305f6d70a1850a660c869bbba2532f8a08a3561073dfd4b7de94ca7634c8"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
