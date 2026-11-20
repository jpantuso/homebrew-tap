# The pony formula for the jpantuso/homebrew-tap tap, as Formula/pony.rb.
# scripts/release-cli.sh writes the version and sha256 lines after notarizing;
# everything else is edited by hand.
class Pony < Formula
  desc "Nagging Apple Reminders from the command line, through the Pony Mac app"
  homepage "https://pantuso.com/pony/"
  version "2026.11"
  url "https://pantuso.com/pony/dl/pony-#{version}.zip"
  sha256 "b6795b2634ec19b19222377077d58d94ee7ac3bb28604d94bcf6f78c89e6b849"
  license :cannot_represent

  # The Pony Mac app needs macOS 27 (Golden Gate), and the CLI does nothing without it.
  depends_on macos: :golden_gate

  def install
    bin.install "pony"
  end

  def caveats
    <<~EOS
      pony talks to the Pony Mac app, which has to be installed from the
      Mac App Store and needs an active Pony subscription:
        https://pantuso.com/pony/
      Check the connection with:
        pony doctor
    EOS
  end

  test do
    # parse is offline and needs neither the app nor a subscription.
    assert_match "how", shell_output("#{bin}/pony parse call mom tomorrow")
  end
end
