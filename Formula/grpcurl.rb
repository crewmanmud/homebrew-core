class Grpcurl < Formula
  desc "Like cURL, but for gRPC"
  homepage "https://github.com/fullstorydev/grpcurl"
  url "https://github.com/fullstorydev/grpcurl/archive/v1.1.0.tar.gz"
  sha256 "8c8af1643c4d549947a2f2198f5c21d634b2a24b31de975a5784841a9127c82f"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    (buildpath/"src/github.com/fullstorydev/grpcurl").install buildpath.children
    cd "src/github.com/fullstorydev/grpcurl/cmd" do
      system "go", "build", "-ldflags", "-X main.version=#{version}",
             "-o", bin/"grpcurl", "./..."
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/grpcurl", "-help"
  end
end
