class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.164/code-aarch64-apple-darwin.tar.gz"
      sha256 "52c56164782d530b87c0074a625e5052e1f8e61b2576d7f24eaadfe6f9302822"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.164/code-x86_64-apple-darwin.tar.gz"
      sha256 "238f4743f6a997e501c89d5cf291f469b03bd14a4e7b7b597c3925eff826b0b1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.164/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6516c6feaee861935daa8333a98763d549817305834d71e68107c97dbdc516a0"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.164/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a21955e12f2c001fd530ca463e50a7a0ee59a295bbccb977acff23801e365ea2"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
