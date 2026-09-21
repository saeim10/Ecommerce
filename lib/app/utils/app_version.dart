import 'package:package_info_plus/package_info_plus.dart';

class AppVersion{
  static String? _currentAppVersion;

  static Future<void> getCurrentVersion() async{
    PackageInfo info = await PackageInfo.fromPlatform();
    _currentAppVersion = info.version;
  }
  static String get currentAppVersion => _currentAppVersion ?? '';
}