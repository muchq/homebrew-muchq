class Microgpt < Formula
  desc "Minimal GPT trainer and chat agent with a from-scratch autograd engine"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/microgpt_cli"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.4.0/microgpt-0.4.0-aarch64-apple-darwin.tar.gz"
    sha256 "714be4566e8138315f0cb9364790e4f0652e2bd96c67ea05e73f50a05281967b"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.4.0/microgpt-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "802df176feff30541bc619bdad5507381be4fc4ad79ccadd4ed139d6de90abd5"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/microgpt.rb`
  head do
    url "https://github.com/muchq/MoonBase.git", branch: "main"
    depends_on "rust" => :build
  end

  resource "chat-model" do
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.3.1/chat-model.tar.xz"
    sha256 "e6f9255e17bd1e39fe9be805dcd0bd91cfc3f6d0ae6c24eabf692201d3acb943"
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "domains/ai/apps/microgpt_cli")
    else
      bin.install "microgpt"
    end

    model_dest = pkgshare/"default-chat-model"
    model_dest.mkpath
    resource("chat-model").stage do
      cp "meta.json", model_dest
      cp "weights.json", model_dest
    end
  end

  def caveats
    <<~EOS
      A default chat model has been installed to:
        #{pkgshare}/default-chat-model

      To use it, copy it to your config directory:
        mkdir -p ~/.config/microgpt
        cp -r #{pkgshare}/default-chat-model ~/.config/microgpt/default-chat-model
    EOS
  end

  test do
    assert_match "microgpt", shell_output("#{bin}/microgpt --version")
  end
end
