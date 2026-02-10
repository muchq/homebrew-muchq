class ImpactMcp < Formula
  desc "Local-first AI agent helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase"
  license "MIT"
  version "0.0.7-alpha"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "717591bbfd0ff1a0c35b29eefbface03d9bbafd9db389701b65e4609993beb9d"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2227d74686d1ca91b63d78c23cc294809adff9a217f051b1a4af5fcb28e4f86f"
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
