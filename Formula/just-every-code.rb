class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.186/code-aarch64-apple-darwin.tar.gz"
      sha256 "8217808f4bafe77a3003510c0020ecaa13d924c160dc5664a205258371aad3e1"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.186/code-x86_64-apple-darwin.tar.gz"
      sha256 "2eec85ff294cfaa0c96c96658b90a58fa52414f610fe23acee94cb3b26a48ec9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.186/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4416c8761116b37e6d528c81c8de49d0115e111ca8cd4794bd02f8160f6a288e"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.186/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "35439a2001bdc714e71cb3a71a0c5e0335c682714bc1df8130d545b67ad51e63"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
