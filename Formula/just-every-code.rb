class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.188/code-aarch64-apple-darwin.tar.gz"
      sha256 "3bb4eb8c6ea60846398cbfe11a5f47432b3755a7fcdc69722ff0921fa34b08fe"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.188/code-x86_64-apple-darwin.tar.gz"
      sha256 "7e66404bfcf28904e0fb106c2b727687f2437d0985e2fedd70b9c48ffc3296fe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.188/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "61e6e41cf3977998b7069f108cb46f9fdafc531fec852b71a3ee905483cbf93a"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.188/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "80ab240183ecf104bdfe8c37fa9512ed95b5c13b78cde699d88ced9fd65a93db"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
