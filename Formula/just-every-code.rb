class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.158/code-aarch64-apple-darwin.tar.gz"
      sha256 "aa4ef7809d35b9fba7476c2c44a677b068b50dc047df082d5dd25366390c19b9"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.158/code-x86_64-apple-darwin.tar.gz"
      sha256 "7cbfdfd337a4543f184ad363a2e4025eafd55b2d04f3768c55b7cb72f0f529c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.158/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "42fb06a1db8d4df735af754f9aace26e828d0d9a66d5630ac7f21cb3c69a49b2"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.158/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "caf71e0f761a799985dc18a36541de532602138ba81945a5664263a2542b95d6"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
