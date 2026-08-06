class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.169/code-aarch64-apple-darwin.tar.gz"
      sha256 "165b390413c60b737e537f5c1b2838c7eed2d0f09a0b493555128215a2a06800"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.169/code-x86_64-apple-darwin.tar.gz"
      sha256 "70ad136c5330554555bdf288015fbbfaa5d6ab027e02a0c8f4152e4b194cdd4a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.169/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "865021876f21a65d25c9b0036e4b5afd51b093c379c7d4592ce05a7e81e3d177"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.169/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0611677bc6aa9fa4cbd3835d899edc87ca191e3b58e3a78ecab3a2da3a0fa2c6"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
