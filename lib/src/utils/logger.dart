import 'dart:io';

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
    stderr.writeln('❌ $message');
  }

  static void step(String message) {
    print('📝 $message');
  }
}
