class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.179/code-aarch64-apple-darwin.tar.gz"
      sha256 "ef615527d25c9a0583e5fd5ca279982dd3dce4709653b77f42fa6bc6307c0721"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.179/code-x86_64-apple-darwin.tar.gz"
      sha256 "f7fd19706878c976bcfe0010aa4c1d0e6638babeac7586c4a4dc4cface4dd249"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.179/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2b925cbb1839f7ea7974044c4cea25c45c10ee680528fb95e6b6b3b677b0c1c0"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.179/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "753384aff76946dbb09ec9dfe7139ec20fe922f514ad93d23e2d4961e27f8da9"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
