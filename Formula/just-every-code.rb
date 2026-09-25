class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.192/code-aarch64-apple-darwin.tar.gz"
      sha256 "e09f1dd5a7abf803d00ff2d86f276e5617bdafde2b1ecea7e291d1b6d104fcb9"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.192/code-x86_64-apple-darwin.tar.gz"
      sha256 "e045157d211c37ddad0d4cc9036ee1f17a4cea349085692c00b1552f3a5457f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.192/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8be8e6bf713b6256b068fdb27e72827bb4ded147e304e418b67420dc4bf2f807"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.192/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3094bbc8ba2f051df2cbfb5fd9997aa04c68c7602ec3043450353909e6456bb1"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
