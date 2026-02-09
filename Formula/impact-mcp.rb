class ImpactMcp < Formula
  desc "Local-first AI agent helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase"
  license "MIT"
  version "0.0.6-alpha"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "02a169d18ab8a19d3f6cd3af9f0bdc5a4b553ebc8533576d9d8ddd20681ca4a2"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "33afe9fc7c3a17559a26bdedb70c7131669156bfc4b18f97b15544c5a939b66e"
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
