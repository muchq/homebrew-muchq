class Microgpt < Formula
  desc "Minimal GPT trainer and chat agent with BPE tokenization and Metal acceleration"
  homepage "https://github.com/muchq/MoonBase/tree/main/domains/ai/apps/microgpt_cli"
  license "MIT"

  if OS.mac?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.6.1/microgpt-0.6.1-aarch64-apple-darwin.tar.gz"
    sha256 "fe39355a9d61fe9a168be8314713c921a5d7f6b6b2312ae7f0a3eb5732c49da5"
  elsif OS.linux?
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.6.1/microgpt-0.6.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f06cc664e1bdc51a24b61d503c767362eb577394f4db5d9a1f3ae3f7f2942e07"
  end

  # For development: build from source instead of downloading a release
  # To use: `brew install --build-from-source ./Formula/microgpt.rb`
  head do
    url "https://github.com/muchq/MoonBase.git", branch: "main"
    depends_on "rust" => :build
  end

  resource "chat-model" do
    url "https://github.com/muchq/MoonBase/releases/download/microgpt-v0.6.0/chat-model.tar.xz"
    sha256 "34c7a86dd163c6d6c5529655afc8739e3db3795dfa42db827254918643ae95f3"
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
      cp "tokenizer.json", model_dest
      cp "weights.safetensors", model_dest
    end
  end

  def caveats
    <<~EOS
      A default chat model has been installed to:
        #{pkgshare}/default-chat-model

      To use it, copy it to your config directory:
        mkdir -p ~/.config/microgpt
        cp -r #{pkgshare}/default-chat-model ~/.config/microgpt
    EOS
  end

  test do
    assert_match "microgpt", shell_output("#{bin}/microgpt --version")
  end
end
