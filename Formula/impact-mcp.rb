class ImpactMcp < Formula
  desc "Local-first AI toolkit helping engineers amplify impact and grow in their role"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/impact_mcp"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v0.0.11/impact-mcp-0.0.11-aarch64-apple-darwin.tar.gz"
    sha256 "2da3b8adfa8920bc95700ebec10555e22a0f0d2791930e6e9d63eafb7ef0669d"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/impact-mcp-v0.0.11/impact-mcp-0.0.11-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "34ab7591b5ce05868bef235b5c236239fec292e68cdef03b49a7c656a52e7364"
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
