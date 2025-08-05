/// A cross-platform logger that works with WASM and all Dart runtimes.
///
/// This logger provides consistent output formatting across different platforms
/// without relying on dart:io, making it compatible with web and WASM environments.
class Logger {
  static void info(String message) {
    print('ℹ️  $message');
  }

  static void success(String message) {
    print('✅ $message');
  }

  static void warning(String message) {
    print('⚠️  $message');
  }

  static void error(String message) {
    // Use print instead of stderr for WASM compatibility
    print('❌ $message');
  }

  static void step(String message) {
    print('📝 $message');
  }
}
