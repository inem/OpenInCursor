# Adding Open in Cursor to Homebrew

## Creating Cask File

Cask file has been created: `Casks/open-in-cursor.rb`

## Process for Adding to Homebrew

1. **Fork the Homebrew Cask repository:**
   ```bash
   gh repo fork Homebrew/homebrew-cask
   ```

2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/homebrew-cask.git
   cd homebrew-cask
   ```

3. **Copy the cask file:**
   ```bash
   cp /path/to/OpenInCursor/Casks/open-in-cursor.rb Casks/
   ```

4. **Create branch and commit:**
   ```bash
   git checkout -b add-open-in-cursor
   git add Casks/open-in-cursor.rb
   git commit -m "Add Open in Cursor cask"
   ```

5. **Push and create Pull Request:**
   ```bash
   git push origin add-open-in-cursor
   gh pr create --title "Add Open in Cursor" --body "Add Open in Cursor cask - Finder toolbar app to open current folder in Cursor"
   ```

## Requirements for Homebrew Cask

- ✅ Application must be in a public repository
- ✅ Must have stable releases with archives (`.zip`, `.dmg`, etc.)
- ✅ SHA256 checksum (can use `:no_check` for initial version, but better to specify actual hash)
- ✅ Minimum macOS version (`depends_on macos: ">= :high_sierra"`)

## Testing Cask

Before submitting PR, test the cask locally:

```bash
brew install --cask --build-from-source /path/to/Casks/open-in-cursor.rb
brew audit --cask --new /path/to/Casks/open-in-cursor.rb
```

## Getting SHA256

For release v1.0.1:

```bash
curl -sL https://github.com/inem/OpenInCursor/releases/download/v1.0.1/Open-in-Cursor.app.zip | shasum -a 256
```

Then update the cask file:
```ruby
sha256 "obtained_hash"
```

## Alternative: Using Tap (for testing)

You can create your own tap for testing:

```bash
# Create a tap repository on GitHub: homebrew-open-in-cursor
# Then:
brew tap YOUR_USERNAME/open-in-cursor
brew install open-in-cursor
```
