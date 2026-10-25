# Homebrew cask for Skriuw:
#   brew install --cask skriuw/tap/skriuw
#
# `version` and the two `sha256` values are rewritten by the manifests job in
# remcostoeten/skriuw's .github/workflows/publish-linux-repos.yml whenever a
# v2 release is published — do not bump them by hand.
cask "skriuw" do
  arch arm: "aarch64", intel: "x64"

  version "0.53.0"
  sha256 arm: "bae106413f567af584574557c3764da60cdb47e6efa341e0f8308dcee4eb6166", intel: "c1350877cd41f973a3432e6e78838d9c75520a56c0046613b9f4edce62379d86"

  url "https://github.com/remcostoeten/skriuw/releases/download/v2-v#{version}/Skriuw_#{version}_#{arch}.dmg"
  name "Skriuw"
  desc "Quiet writing workspace for notes, journaling, sharing, and planning"
  homepage "https://skriuw.com"

  livecheck do
    url :url
    regex(/^v2[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  app "Skriuw.app"

  # The .dmg is not signed/notarized, so Gatekeeper would refuse to open it;
  # dropping the quarantine attribute after install makes it launchable.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Skriuw.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/nl.remcostoeten.skriuw.dev",
    "~/Library/Caches/nl.remcostoeten.skriuw.dev",
    "~/Library/WebKit/nl.remcostoeten.skriuw.dev",
  ]
end
