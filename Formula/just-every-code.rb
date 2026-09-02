class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.177/code-aarch64-apple-darwin.tar.gz"
      sha256 "b2befcd7e03079d3472808c13b3e1f3953178a35985e0940210524f6eeb481ea"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.177/code-x86_64-apple-darwin.tar.gz"
      sha256 "ba657df76518c222fb158cad74707de6c5cfff67f4f0a0ce93d238012ff59118"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.177/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "753e4ce575f26b5d3ba8b63d5d880cb64205d3b92bcbb00b56f44d24e956a658"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.177/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bf64f7cca183bf7d510f59f4f5f936e99eba3910f0ff617de2eacc2d0158728f"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
