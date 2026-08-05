class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.168/code-aarch64-apple-darwin.tar.gz"
      sha256 "da8624403561f542a3d1011b8b1e9e3f1d8408febf349a58c47440652c128a12"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.168/code-x86_64-apple-darwin.tar.gz"
      sha256 "4ceb5cbfb644c3202c7c8b29f0a55a76418c6b0b4bbed7087b005e63eaed7bbf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.168/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3bd21c8f7d15f922b915f522efddb294ed890444c87502db0ccee9beaa03c70b"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.168/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "477a1866ab1952e9ad158c02e86ebc6d8a85294ea200d06d9ee7ad83ff8d7e37"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
