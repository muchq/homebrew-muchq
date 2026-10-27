class ImpactMcp < Formula
  desc "Local-first AI toolkit helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/impact_mcp"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v0.0.12/impact-mcp-0.0.12-aarch64-apple-darwin.tar.gz"
    sha256 "533869c7a78f30b24344e21d83fe686cfac0261167223c1040d92b426b1a17af"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v0.0.12/impact-mcp-0.0.12-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a6dd2cc657a0e84522f5ec1d5e39bf2b4e16668c8e3bfac8fc7dfc02fc0ed2cf"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/impact-mcp.rb`
  head do
    url "https://github.com/muchq/MoonBase.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "domains/ai/apps/impact_mcp")
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
