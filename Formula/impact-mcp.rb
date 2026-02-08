class ImpactMcp < Formula
  desc "Local-first AI agent helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase"
  license "MIT"
  version "0.0.1-alpha"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "14e3c2004bbb692ae389fd2510be2d80edd28121df5844a078ad251662bf84fa"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f202206ccb6682d0222e8c3c76ea91c4f6cf3c2a7a03045a4074fa8f0a8ab39f"
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
