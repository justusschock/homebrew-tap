class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.178/code-aarch64-apple-darwin.tar.gz"
      sha256 "67b76ea6769a8791dbd672e240a4243363d6d36682d5db84724fab02ae8848d8"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.178/code-x86_64-apple-darwin.tar.gz"
      sha256 "247d6e04ff044f6e316348101e6423b33619372d59ecbce9457d0b60bec79e72"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.178/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d8d547ffd1c92f9999b6e6354641bc88e4f93cf2d08d2f320cd460908ada95f2"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.178/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "df6419aa612d8c0ba885f99d01ef1403a8aaa22ee393671a738bf427ba978d4c"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
