# Homebrew cask for Skriuw:
#   brew install --cask skriuw/tap/skriuw
#
# `version` and the two `sha256` values are rewritten by the manifests job in
# remcostoeten/skriuw's .github/workflows/publish-linux-repos.yml whenever a
# v2 release is published — do not bump them by hand.
cask "skriuw" do
  arch arm: "aarch64", intel: "x64"

  version "0.46.1"
  sha256 arm: "96bb74983c8a68236fe1bc325662681997e4c80b8d93a09dcde2930cff4b6c29", intel: "48ef5886a8745411baa9379d1442e3b278df04b0e3ecf0d4c368fcb18fae2364"

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
