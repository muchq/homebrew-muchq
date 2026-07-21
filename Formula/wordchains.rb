class Wordchains < Formula
  desc "Solver for Lewis Carroll's Doublets (word ladder) puzzle"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/games/apps/wordchains"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.3/wordchains-0.1.3-aarch64-apple-darwin.tar.gz"
    sha256 "b4460ac88963b4da733da2e5368ae8bf6c6ce411dc30666f98d96d575b58d552"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.3/wordchains-0.1.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9eb967282b68988ac725fcd0092979e35f05eb1ecb7e7640c951a20bfa056f6b"
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
