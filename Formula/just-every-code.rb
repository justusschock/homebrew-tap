class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.195/code-aarch64-apple-darwin.tar.gz"
      sha256 "5cf4b48db3ce125d7f95c170b90f5ae018f574f99219312420da64877c0196c1"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.195/code-x86_64-apple-darwin.tar.gz"
      sha256 "d9a148af176fa96081d02462442311d144967a627a9179b9ecf3b4d047884462"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.195/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "525e6e90c23b3e88f1b6be9e9a491d01c599734b64bb18e039164c94b516c2a0"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.195/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a4be06a8f89846df16f2aaa477e49556da570e92d287399a4619f54da5d2b236"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
