class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.181/code-aarch64-apple-darwin.tar.gz"
      sha256 "05175caad97bb5ac4e2d33f0c643ff1361b134cc173a64357606bc80c9eebd65"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.181/code-x86_64-apple-darwin.tar.gz"
      sha256 "36651e0e281b2d9747a0b9fc58f350844ba649f596cfd95e91235630896271fa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.181/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b55f8c0bb83872c9a2d8dac206fd280b4d30605e8b0f856f64b7d93851d51b7d"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.181/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1eca754e59e477b2bb76c2dc76baacafa5cac06d10ea8e7e312f364431b19aee"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
