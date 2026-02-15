class Microgpt < Formula
  desc "A minimal GPT trainer and chat agent with a from-scratch autograd engine"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/microgpt_cli"
  license "MIT"
  version "0.1.0"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v#{version}/microgpt-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "01f78b8212fbf44d57e706cdd7a287462a9d2004f8aa4a162bce26082bd2b3d0"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v#{version}/microgpt-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "312419fe56a2b46c1fb6435df93136ef8485110c8eb497ebc086322c580cbcac"
  end

  def install
    bin.install "microgpt"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/microgpt.rb`
  head "https://github.com/muchq/MoonBase.git", branch: "main"

  head do
    depends_on "rust" => :build

    def install
      system "cargo", "build", "--release", "--manifest-path", "domains/ai/apps/microgpt_cli/Cargo.toml"
      bin.install "target/release/microgpt"
    end
  end

  test do
    assert_match "microgpt", shell_output("#{bin}/microgpt --version")
  end
end
