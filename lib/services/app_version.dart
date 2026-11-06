abstract final class AppVersion {
  static const int major = 2;
  static const int minor = 0;
  static const int ultraminor = 0;
  static const String string = '$major.$minor.$ultraminor';
  static const String display = 'v$string';
  static const String userAgent = 'Rin23/$string';
}
