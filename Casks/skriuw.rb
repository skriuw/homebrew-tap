# Homebrew cask for Skriuw:
#   brew install --cask skriuw/tap/skriuw
#
# `version` and the two `sha256` values are rewritten by the manifests job in
# remcostoeten/skriuw's .github/workflows/publish-linux-repos.yml whenever a
# v2 release is published — do not bump them by hand.
cask "skriuw" do
  arch arm: "aarch64", intel: "x64"

  version "0.51.0"
  sha256 arm: "02658c676053758746990b3d62a12538176deb53ebf5e77c466a2ad3349a87f1", intel: "ab59fc99dbdd9e66e745e0f724a79dbb6bcb352bc1683a8909a13a455c74f952"

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
