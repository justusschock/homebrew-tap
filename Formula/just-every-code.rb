class JustEveryCode < Formula
  desc "Fast, local coding agent for the terminal"
  homepage "https://github.com/just-every/code"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.185/code-aarch64-apple-darwin.tar.gz"
      sha256 "714d584d3bc37af90d95a920f1afe1931cf32301e0c0668959d891727bbe75c1"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.185/code-x86_64-apple-darwin.tar.gz"
      sha256 "d33e63a68d17c29547bcfcc7bdbb5335135c0b2db92f4c2f9de5365074ac705f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/just-every/code/releases/download/v0.6.185/code-aarch64-unknown-linux-musl.tar.gz"
      sha256 "20740ab76ba4bd2394f2df03601406a69ef826628fda579183e709c025ab3db7"
    else
      url "https://github.com/just-every/code/releases/download/v0.6.185/code-x86_64-unknown-linux-musl.tar.gz"
      sha256 "229257be30d2f687e7cdd559b3dabeda00e43534c870c115a57dfa679b245296"
    end
  end

  def install
    bin.install Dir["code-*"].first => "coder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coder --version")
  end
end
