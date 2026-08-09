class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.170/code-aarch64-apple-darwin.tar.gz"
      sha256 "e157b2e81369669f4d242116bfb24cf84d34515b8166604806cefde82af37f17"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.170/code-x86_64-apple-darwin.tar.gz"
      sha256 "d28e3ed778cf1de93ae3e35daba4d28edbccadff418e93e8c0a36bf4abbdf57c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.170/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8fab092977cb7c2f2e0bc5d7740dfcb355117bb833dc71f7e5f3440cb2d6d86b"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.170/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "af38d9229e60c4ecf2c21f91b586cd661c26ecd473eea0f6fa0e3071318b7902"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
