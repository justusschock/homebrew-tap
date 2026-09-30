class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.196/code-aarch64-apple-darwin.tar.gz"
      sha256 "b0a867e61ef1e3e3b697642c55ecc73a4234948c3f9f3733674d812fded22319"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.196/code-x86_64-apple-darwin.tar.gz"
      sha256 "f12ca5a0dc3ee66b2110e2a5285cd5a109ae8d046e8fc88dc9d4124d47133157"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.196/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c08745c2a549fa6a416ba9036a6f78e7d7bb34203aa88677fa7be638a581fef2"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.196/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "04d223fffb8ed1a54fd80eba89239e439785d848d27dab6355dfe53b7d5e01d2"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
