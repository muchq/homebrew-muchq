class Wordchains < Formula
  desc "Solver for Lewis Carroll's Doublets (word ladder) puzzle"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/games/apps/wordchains"
  license "MIT"
  version "0.1.0"

  on_macos do
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v#{version}/wordchains-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "aa8944e76050742a53391674f22522e401255efea998a57a580012f93fd0ab9c"
  end

  on_linux do
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v#{version}/wordchains-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5dd9394f6b9477e162a11affff79f0c0b85762673b13bd0ff25e4201ae06f824"
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
