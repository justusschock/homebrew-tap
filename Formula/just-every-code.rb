class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.189/code-aarch64-apple-darwin.tar.gz"
      sha256 "6c6e95599df60d0ed111c22086a198db083620eccee9cb01249f2bd52b95b7b4"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.189/code-x86_64-apple-darwin.tar.gz"
      sha256 "d3fa15012b1ae7620c93b2bb98c0555dfc5628cbdd93df820a9936049ae888ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.189/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c2adcdcc2540d8e9f4f5358de987e184892577b5ee830f092f5cfe56ab7b47f8"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.189/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5f38f0566ea1df806944bb73c4f26e96b0542577be7b4a13f0ade314ce0d55cb"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
