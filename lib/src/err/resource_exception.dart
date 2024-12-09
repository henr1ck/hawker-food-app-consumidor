class ResourceNotFoundException implements Exception {
  final String message;

  ResourceNotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}
