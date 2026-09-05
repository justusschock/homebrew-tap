class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.180/code-aarch64-apple-darwin.tar.gz"
      sha256 "07f356c9ab17bb6ec33d0597521b5aa65f732501cbb84b770e5861d7ade1aa4c"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.180/code-x86_64-apple-darwin.tar.gz"
      sha256 "0e2241b1335ec248630468d003b60f82fda265be435532e6a3cee680a3eceb73"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.180/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e01673676deea48fefb73e058fe85dc64514d5d63d9a74f2daa3e3a32e879cdf"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.180/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "76890b94d1ad2476713c74c906f98175f24b9d1ff5ec28a4fb2bca6b9f38706c"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
