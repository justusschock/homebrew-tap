class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.194/code-aarch64-apple-darwin.tar.gz"
      sha256 "e36c1d888da6158de3dc954ded9d30afcb0db9938feef79b7aedc2b4eab59ad0"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.194/code-x86_64-apple-darwin.tar.gz"
      sha256 "f39dc57a76e5fdc5084aab29ae6dbd4ba1c1817da1cf0f64bc8c4dd8615e9531"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.194/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7ea649676648d4e6bd03823bf07c93eed0e107330af1e5cdc9b56777a4d4a020"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.194/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "728eed7e3c2cff96e9e3426bb9ed5f13554c38ec77b2a7ea8de9bb765ab81d7a"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
