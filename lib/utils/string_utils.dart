String toPascalCase(String input) {
  return input.split('_').map((e) => e.isEmpty ? '' : '${e[0].toUpperCase()}${e.substring(1)}').join();
}

String toSnakeCase(String input) {
  final regex = RegExp(r'(?<=[a-z0-9])[A-Z]');
  return input.replaceAllMapped(regex, (match) => '_${match.group(0)}').toLowerCase();
}
