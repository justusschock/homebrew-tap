class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.193/code-aarch64-apple-darwin.tar.gz"
      sha256 "afa3f6a360271a1a6cfde7706a210ebe3b7fdbb7b606ebf560d78ba5d5de1bb2"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.193/code-x86_64-apple-darwin.tar.gz"
      sha256 "62dbf29ba56aa26d93be5669434349ec1994154ddc12ea4d639dc5fca7ef1675"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.193/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2a8a54c8bf325c9fdc2c76e9154a1e82ce54fbf29dd0f47c6e7027ada88502a1"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.193/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6eb52c29bb432a37a5904c5741d65b905c4d015efe1ce013c717b95b1bd6dc31"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
