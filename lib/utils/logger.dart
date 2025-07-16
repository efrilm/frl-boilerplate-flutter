class Logger {
  static void info(String message) {
    print('ℹ️  $message');
  }

  static void success(String message) {
    print('\x1B[32m✅ $message\x1B[0m'); // green
  }

  static void warning(String message) {
    print('\x1B[33m⚠️  $message\x1B[0m'); // yellow
  }

  static void error(String message) {
    print('\x1B[31m❌ $message\x1B[0m'); // red
  }

  static void section(String message) {
    print('\n🔹 \x1B[36m$message\x1B[0m'); // cyan
  }

  static void skip(String message) {
    print('\x1B[34m⏭️  $message\x1B[0m'); // blue
  }
}
