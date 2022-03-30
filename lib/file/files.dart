class Files {
  static double kb(int sizeInBytes) {
    return sizeInBytes / 1024;
  }

  static double mb(int sizeInBytes) {
    return Files.kb(sizeInBytes) / 1024;
  }
}
