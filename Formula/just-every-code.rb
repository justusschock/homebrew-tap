class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.160/code-aarch64-apple-darwin.tar.gz"
      sha256 "2b40eb94fae8a51c44fd0e2866309d2cdaef9c298b08e8418adb469382dbd653"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.160/code-x86_64-apple-darwin.tar.gz"
      sha256 "e2537fc4cd5a7cc4686dc27f405270f2116027de9076b6a2bfb12bb52de5a394"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.160/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "812f2a35a8d7dd3cc31349567f737f6dea599331937e665580ea07d42a1b492e"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.160/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "29b0ff476de0839961ba4af69119a8ff0a8de3276f9e7f1b1bcdfb53c12bfbaa"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
