class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.162/code-aarch64-apple-darwin.tar.gz"
      sha256 "893fdf72444eeb7480674632985f4ba30dcf00c15db3cf4d6b8b317192c66c30"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.162/code-x86_64-apple-darwin.tar.gz"
      sha256 "09ed916dc4b034a2bf362fba934c8632b2185137d7773083716ac5a906a12ecb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.162/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "781aed058cf4dd435baaf52b7f795da22e3a1ded7563b546c25a4aefbec371b9"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.162/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f1e8034b3c1b1398770d349441b69c5b885048287950e18dabaea73f51e20671"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
