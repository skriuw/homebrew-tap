# Homebrew cask for Skriuw:
#   brew install --cask skriuw/tap/skriuw
#
# `version` and the two `sha256` values are rewritten by the manifests job in
# remcostoeten/skriuw's .github/workflows/publish-linux-repos.yml whenever a
# v2 release is published — do not bump them by hand.
cask "skriuw" do
  arch arm: "aarch64", intel: "x64"

  version "0.47.0"
  sha256 arm: "1a07ac5b59f9d5003bd81c1083ababbefd09c9c04ae3a6b1ef4a60fff962195d", intel: "dc7c6a907cf8794b4b9c61aae8537cb27c94008bf9c7728a16d5134f6964cf07"

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
