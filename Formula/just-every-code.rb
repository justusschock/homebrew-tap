class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.187/code-aarch64-apple-darwin.tar.gz"
      sha256 "7c3dae0f033d93a41bbb0a6f9c46c933dc83c90811b8de568c7d0a3526becda7"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.187/code-x86_64-apple-darwin.tar.gz"
      sha256 "931c959ab34268edd414ded7d3dfd3b2125b900904403cba3d979199e67e5aba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.187/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "90b06a05fd948132408ba3d4385c441bbc0f58b529fa136366a1ff2b01f74846"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.187/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5aa86c03cf5152da063e715ad3026655dc5b2f302c7eb1591650086fb736753d"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
