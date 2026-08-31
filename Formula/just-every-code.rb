class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.175/code-aarch64-apple-darwin.tar.gz"
      sha256 "1fa4a2b1422fcf69004236fa7c0293b997b804986ad0d780839f38df8e366fcf"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.175/code-x86_64-apple-darwin.tar.gz"
      sha256 "18cd219b627a6dd380235c85ebd42eb200d8994b08c407f4cb9b0653620dfea0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.175/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "552744f15ce6dc59c7d39bd48317564f20a734f707178dbd934ead395ff41bc6"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.175/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0bad4c5c3a729c03089ceed9e6f0b3d9a5d5632046098e60952bba6d15dc1056"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
