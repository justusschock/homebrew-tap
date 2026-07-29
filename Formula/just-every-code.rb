class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.156/code-aarch64-apple-darwin.tar.gz"
      sha256 "1f440d0fc7a047f6486cc6d529879b8176832c8b4eacb34ca65c0622aafeb4d8"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.156/code-x86_64-apple-darwin.tar.gz"
      sha256 "af7b1e7aa5dc4713964601a436296678472289148cafa56bb7dbf9c76c2c20aa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.156/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e20efb7acea4636f915d1bfc1723774ba9a6b7bc5469e53bf62cf4e70d53d5f2"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.156/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d00151979c22ae2442618fac535b9a485f4bd7a18b21441daa0f0bc4353e7ac8"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
