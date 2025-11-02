.PHONY: build clean install open xcode

# Build configuration
SCHEME = "Open in Cursor"
PROJECT = "Open in Cursor.xcodeproj"
CONFIG = Release
# Xcode builds to DerivedData, so we need to find it there
OUTPUT_DIR = $(shell find ~/Library/Developer/Xcode/DerivedData/Open_in_Cursor-*/Build/Products/Release -name "Open in Cursor.app" -type d 2>/dev/null | head -1 | xargs dirname 2>/dev/null || echo "build/Release")

# Default target
all: generate-finder build

# Generate Finder.h from Finder.app
generate-finder:
	@echo "Generating Finder.h..."
	@sdef /System/Library/CoreServices/Finder.app | sdp -fh -o . --basename Finder --bundleid com.apple.finder || echo "Warning: Failed to generate Finder.h (may already exist)"

# Build the app
build: generate-finder
	@echo "Building Open in Cursor..."
	@xcodebuild -project $(PROJECT) \
		-scheme $(SCHEME) \
		-configuration $(CONFIG) \
		clean build
	@echo "Build complete! App location: $(OUTPUT_DIR)/Open in Cursor.app"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf build
	@rm -f Finder.h
	@echo "Clean complete"

# Install app to /Applications
install: build
	@echo "Installing to /Applications..."
	@APP_PATH=$$(find ~/Library/Developer/Xcode/DerivedData/Open_in_Cursor-*/Build/Products/Release -name "Open in Cursor.app" -type d 2>/dev/null | head -1); \
	if [ -z "$$APP_PATH" ]; then \
		echo "Error: App not found in DerivedData"; \
		exit 1; \
	fi; \
	cp -R "$$APP_PATH" /Applications/ && \
	echo "Installed to /Applications/Open in Cursor.app"

# Open project in Xcode
open:
	@open $(PROJECT)

# Alias for open
xcode: open

# Show app location after build
show:
	@APP_PATH=$$(find ~/Library/Developer/Xcode/DerivedData/Open_in_Cursor-*/Build/Products/Release -name "Open in Cursor.app" -type d 2>/dev/null | head -1); \
	if [ -n "$$APP_PATH" ]; then \
		echo "App location: $$APP_PATH"; \
		open "$$APP_PATH"; \
	else \
		echo "App not found. Run 'make build' first."; \
	fi

# Help
help:
	@echo "Available targets:"
	@echo "  make         - Generate Finder.h and build app (default)"
	@echo "  make build   - Build the app"
	@echo "  make clean   - Remove build artifacts"
	@echo "  make install - Build and install to /Applications"
	@echo "  make open    - Open project in Xcode"
	@echo "  make show    - Show built app location"
	@echo "  make help    - Show this help message"

