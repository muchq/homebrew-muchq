class Wordchains < Formula
  desc "Solver for Lewis Carroll's Doublets (word ladder) puzzle"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/games/apps/wordchains"
  license "MIT"
  version "0.0.1-alpha"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v#{version}/wordchains-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v#{version}/wordchains-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    bin.install "wordchains"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/wordchains.rb`
  head "https://github.com/muchq/MoonBase.git", branch: "main"

  head do
    depends_on "rust" => :build

    def install
      system "cargo", "build", "--release", "--manifest-path", "domains/games/apps/wordchains/Cargo.toml"
      bin.install "target/release/wordchains-bin" => "wordchains"
    end
  end

  test do
    assert_match "wordchains", shell_output("#{bin}/wordchains --help")
  end
end
