class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.173/code-aarch64-apple-darwin.tar.gz"
      sha256 "1efa09ba02a3d9f72d2af04435dc6254b47e4d997e443f5c90aa4024e22a2b9d"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.173/code-x86_64-apple-darwin.tar.gz"
      sha256 "2df29d98ef34c930ebdfcd97ce6638cd746df9787b7d68ce1a606cd354f6f5db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.173/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8716c081e00918e1d6d9b369ffc13b9279924a2292c0c59cd19c0c05bebc5a9b"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.173/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "46a457b6e948f6e14c1aa0232737970582c18dc5c88a4e7047b066aa6df585c3"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
