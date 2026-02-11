class ImpactMcp < Formula
  desc "Local-first AI agent helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/impact_mcp"
  license "MIT"
  version "0.0.9-alpha"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "12155eb5558f6dee71f31eef4376735f87aa5c54a32a5011b61df7e74df25699"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "df43b67ebb2fb645d5478126263d6553d502133073488898aff40573617fb5ec"
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
