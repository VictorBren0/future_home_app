String generateUniqueId() {
  final now = DateTime.now();
  final timestamp = now.microsecondsSinceEpoch.toString();
  final random = now.millisecondsSinceEpoch.remainder(1000).toString();
  return timestamp + random;
}