class ImpactMcp < Formula
  desc "Local-first AI toolkit helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/impact_mcp"
  version "0.0.10"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "2bbdd6f41d446d319ecdeb53501a1061cd571e205f17dda8d229a1b719115961"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v#{version}/impact-mcp-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fb541db5368c434e55fea0bb8d8bdc89703b77cf473f5148c2ee21c3b95556cd"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/impact-mcp.rb`
  head do
    url "https://github.com/muchq/MoonBase.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "build", "--release", "--manifest-path", "domains/ai/apps/impact_mcp/Cargo.toml"
      bin.install "domains/ai/apps/impact_mcp/target/release/impact-mcp"
    else
      bin.install "impact-mcp"
    end
  end

  def caveats
    <<~EOS
      To complete the installation, please run:
        impact-mcp setup
    EOS
  end

  test do
    assert_match "impact-mcp", shell_output("#{bin}/impact-mcp --version")
  end
end
