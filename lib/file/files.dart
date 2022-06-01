class Files {
  /// file size in KB
  static double kb(int sizeInBytes) {
    return sizeInBytes / 1024;
  }

  /// file size in MB
  static double mb(int sizeInBytes) {
    return Files.kb(sizeInBytes) / 1024;
  }
}
