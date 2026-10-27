class Wordchains < Formula
  desc "Solver for Lewis Carroll's Doublets (word ladder) puzzle"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/games/apps/wordchains"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.4/wordchains-0.1.4-aarch64-apple-darwin.tar.gz"
    sha256 "c849041971d911904b38cc804da78f41816412a1ff132d376e39192a9cfec778"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/wordchains-v0.1.4/wordchains-0.1.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4fb096677c80d14430c41bf73ead4480a6c0aba416b21fdb48aeb84b0ab0251f"
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
