class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.166/code-aarch64-apple-darwin.tar.gz"
      sha256 "671f3de7f3ce7632a6ac645b3f20aab77257130ebf813e1b3d806a1dbae6288d"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.166/code-x86_64-apple-darwin.tar.gz"
      sha256 "a52c8158b739622ca108aefaa56fed5e747729c7e1eaf1921cda328137baf595"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.166/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2fcd289f0dfec5f4e41948a97bc66e65dec2ea493e21adb08d875dc9979221cf"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.166/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cbf021ae60445f38fb283506367af62ad8a4f85d747e12346ebaf217c23982f9"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
