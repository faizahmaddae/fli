/// Stub implementation for web/WASM platforms where dart:io is not available.
///
/// This provides a fallback implementation that gracefully handles the case
/// where the CLI tool is imported in a web/WASM environment.
library fli_runner_stub;

/// Runs the fli CLI tool with the provided command-line arguments.
///
/// **Note**: This is a stub implementation for web/WASM platforms.
/// The fli CLI tool requires dart:io capabilities and cannot run in
/// web browsers or WASM environments.
///
/// For actual CLI functionality, use this package on platforms that
/// support dart:io (desktop and mobile platforms).
///
/// ## Arguments
///
/// - [arguments]: A list of command-line arguments (ignored in stub)
///
/// ## Throws
///
/// Always throws an [UnsupportedError] indicating that CLI functionality
/// is not available in web/WASM environments.
void runFli(List<String> arguments) {
  throw UnsupportedError(
    'CLI functionality is not available in web/WASM environments. '
    'Please use this package on desktop or mobile platforms that support dart:io.',
  );
}
