#!/bin/bash

# Install script for fli - Flutter Project Structure Generator
# Usage: curl -fsSL https://raw.githubusercontent.com/yourusername/fli/main/install.sh | bash

set -e

echo "🚀 Installing fli - Flutter Project Structure Generator"

# Check if Dart is installed
if ! command -v dart &> /dev/null; then
    echo "❌ Dart SDK is required but not installed."
    echo "Please install Dart SDK first: https://dart.dev/get-dart"
    exit 1
fi

# Check if pub is available
if ! command -v dart pub &> /dev/null; then
    echo "❌ dart pub command is not available."
    echo "Please ensure Dart SDK is properly installed."
    exit 1
fi

echo "✅ Dart SDK found"

# Install fli globally
echo "📦 Installing fli globally..."
dart pub global activate fli

# Check if pub global bin is in PATH
if ! echo $PATH | grep -q "$(dart pub global --help | grep "\.pub-cache" | cut -d' ' -f1)/bin"; then
    echo "⚠️  Warning: pub global bin directory is not in your PATH"
    echo "Add this to your shell profile (.bashrc, .zshrc, etc.):"
    echo 'export PATH="$PATH:$(dart pub global --help | grep "\.pub-cache" | cut -d'"'"' '"'"' -f1)/bin"'
    echo ""
fi

# Verify installation
if command -v fli &> /dev/null; then
    echo "✅ fli installed successfully!"
    echo ""
    echo "🎉 You can now use fli to generate Flutter projects:"
    echo "   fli create my_app --template=basic"
    echo "   fli templates"
    echo "   fli --help"
else
    echo "⚠️  fli command not found in PATH. You may need to restart your terminal or update your PATH."
    echo "Try running: dart pub global run fli --help"
fi

echo ""
echo "📚 Documentation: https://github.com/yourusername/fli"
echo "🐛 Issues: https://github.com/yourusername/fli/issues"
echo ""
echo "Happy coding! 🎯"
