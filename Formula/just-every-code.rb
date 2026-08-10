class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.171/code-aarch64-apple-darwin.tar.gz"
      sha256 "6499f6e2ac16a79bbcf1d92ace5eb6b57a9004642b407a83bf601122ce59947c"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.171/code-x86_64-apple-darwin.tar.gz"
      sha256 "a84dc919d40865b7ac23dc28757ba21f2007df8561901fc0cb77f7669f4d194b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.171/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "505f2c8929359dc70b3b5567e60ab04e2804e48a61512a6761a5a0cd52f04864"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.171/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "327970f6e37e431d97540613b2956c852f8cecf599dfbe9f558d1d3311da657a"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
