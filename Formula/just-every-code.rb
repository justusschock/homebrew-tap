class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.172/code-aarch64-apple-darwin.tar.gz"
      sha256 "e878b0483e589e1da22a35048012c481b4eb7436856cddaeaadfbb84119c52e7"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.172/code-x86_64-apple-darwin.tar.gz"
      sha256 "32ad50f3da386130f76215cb50156eea62548011c87a40195f2797ae96fc8c75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.172/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0937cea675d2640e17c7a8291c3ef2f0f6ef47248bd1cf4d1b7ed53fb5df6b73"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.172/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dc75e0f37917bef19ac0147b95c9c46f7ae048223b1ddade03708cabddecb82e"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
