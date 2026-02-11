class ImpactMcp < Formula
  desc "Local-first AI agent helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/impact_mcp"
  license "MIT"
  version "0.0.8-alpha"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "a58e4aeaca7f512bad585979441b2b4c90faa7b52bdd6fe8f62548a52d133c2f"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ae45e8a1688696cfb0b3afed4646e28593e07f87ad0b00fd6b116d607d3a4df5"
  end

  def install
    bin.install "impact-mcp"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/impact-mcp.rb`
  head "https://github.com/muchq/MoonBase.git", branch: "main"

  head do
    depends_on "rust" => :build

    def install
      system "cargo", "build", "--release", "--manifest-path", "domains/ai/apps/impact_mcp/Cargo.toml"
      bin.install "target/release/impact-mcp"
    end
  end

  test do
    assert_match "impact-mcp", shell_output("#{bin}/impact-mcp --version")
  end
end
