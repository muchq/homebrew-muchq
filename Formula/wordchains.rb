class Wordchains < Formula
  desc "Solver for Lewis Carroll's Doublets (word ladder) puzzle"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/games/apps/wordchains"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.2/wordchains-0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "30ae59101e223fea1c40ebca0979a7f05dd1e1f00330bf631be87f48160efc34"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.2/wordchains-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e2a2beebcd64795facb04e2cabb321ddd87a4a57bede6033e1a8e700e63cc4a8"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/wordchains.rb`
  head do
    url "https://github.com/muchq/MoonBase.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "domains/games/apps/wordchains")
      mv bin/"wordchains-bin", bin/"wordchains"
    else
      bin.install "wordchains"
    end
  end

  test do
    assert_match "wordchains", shell_output("#{bin}/wordchains --help")
  end
end
