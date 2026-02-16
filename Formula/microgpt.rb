class Microgpt < Formula
  desc "Minimal GPT trainer and chat agent with a from-scratch autograd engine"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/microgpt_cli"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.1.1/microgpt-0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "510c0aa20b258ca9ecbfd4c7b728286b8d693ce4c04191d558bad74f59a9c258"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.1.1/microgpt-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5ceb54a6b2a0051c08f24ca54611674f3a526eba9286ddd6850d909fef3e9ccd"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/microgpt.rb`
  head do
    url "https://github.com/muchq/MoonBase.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "domains/ai/apps/microgpt_cli")
    else
      bin.install "microgpt"
    end
  end

  test do
    assert_match "microgpt", shell_output("#{bin}/microgpt --version")
  end
end
