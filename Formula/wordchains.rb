class Wordchains < Formula
  desc "Solver for Lewis Carroll's Doublets (word ladder) puzzle"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/games/apps/wordchains"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.1/wordchains-0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "6ef19b1e356e5f75047fee4bce111cb5abf28f6149f0a234b3a6e98389f8225c"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.1/wordchains-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0934dc9a06c2179ec2fca662e494ed5227e03b0a0ea6b17d2a446cd63e22b84a"
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
