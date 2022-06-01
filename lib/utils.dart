class Utils {
  Utils._();

  /// check string is null or empty
  static bool isNullOrEmpty(String? str) {
    return (str == null || str.trim().isEmpty);
  }

  /// check strings are equals or not
  static bool equals(String str1, String str2, {bool ignoreCase = true}) {
    if (ignoreCase) {
      return (str1.toLowerCase() == str2.toLowerCase());
    } else {
      return (str1 == str2);
    }
  }
}
