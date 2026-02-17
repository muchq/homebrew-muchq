class Microgpt < Formula
  desc "Minimal GPT trainer and chat agent with a from-scratch autograd engine"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/microgpt_cli"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.2.0/microgpt-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "68f9527db7f27ea975c0fa522a7e114834773d3afbd1f45471245bf16bd77c36"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.2.0/microgpt-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "43c2ccd9558fac2436582721ff6d8d55dbb6245db1fe02cd3178943e65a45a0d"
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
