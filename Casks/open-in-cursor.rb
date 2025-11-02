cask "open-in-cursor" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/inem/OpenInCursor/releases/download/v#{version}/Open-in-Cursor.app.zip"
  name "Open in Cursor"
  desc "Finder toolbar app to open current folder in Cursor"
  homepage "https://github.com/inem/OpenInCursor"

  depends_on macos: ">= :high_sierra"

  app "Open in Cursor.app"

  zap trash: [
    "~/Library/Preferences/com.inem.openincursor.plist",
  ]
end

