class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.165/code-aarch64-apple-darwin.tar.gz"
      sha256 "b97427abe351a18655ffb1299b5dd4c50d78097f05282d8407b6f73beea4fb41"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.165/code-x86_64-apple-darwin.tar.gz"
      sha256 "6bb0998826cc4cc8236fd7de3037af116fa59ab42b0ac5b9826de591bfb1b8c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.165/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "80aa0141df161b5f395d4bf9b8e5232bbbc40e8b5fbdeb9593d9019c3cfa21da"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.165/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3b03bc83c976bf23e4775ae8a488c10e4c430794e88c1f645576a3a168dcf506"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
