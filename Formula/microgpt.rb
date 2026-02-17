class Microgpt < Formula
  desc "Minimal GPT trainer and chat agent with a from-scratch autograd engine"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/microgpt_cli"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.3.1/microgpt-0.3.1-aarch64-apple-darwin.tar.gz"
    sha256 "c8df55b291314e5edf32d93602cf50771140256050e989b94ee50a1e41ef01c9"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.3.1/microgpt-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "69d7786f476dc2c584841245898b0dde1d35642d5b0329c35767d84f36d79e04"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/microgpt.rb`
  head do
    url "https://github.com/muchq/MoonBase.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "domains/ai/apps/microgpt_cli")
    else
      bin.install "microgpt"
    end
  end

  test do
    assert_match "microgpt", shell_output("#{bin}/microgpt --version")
  end
end
