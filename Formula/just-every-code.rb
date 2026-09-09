class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.182/code-aarch64-apple-darwin.tar.gz"
      sha256 "e2bee80b9e3f22d4126aecaa48fb4dae0584eef581064e3f43a9c655c267e85e"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.182/code-x86_64-apple-darwin.tar.gz"
      sha256 "c5f1b40fc587d843ba3228e3517a0c88e6b252b67b2e627f070ed5342476b0f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.182/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "645f455df17fb67d6d7cb2ce517f7fa2a9177d3ebea8054d54d7403dc1e6d80d"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.182/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0a45a8ad3f5ab923f9bd555e77b90a718c82b0d1576ccb98d79f1ae18c6550be"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
