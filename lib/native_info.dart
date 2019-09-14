library native_info;

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class NativeInfo {
  static PackageInfo packageInfo;
  static _DeviceInfo deviceInfo;

  static configure() async {
    assert(Platform.isIOS || Platform.isAndroid);
    packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceInfo = _DeviceInfo(
          iosDeviceInfo.name,
          iosDeviceInfo.systemName,
          iosDeviceInfo.systemVersion,
          iosDeviceInfo.isPhysicalDevice,
          iosDeviceInfo.identifierForVendor);
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceInfo = _DeviceInfo(
          androidDeviceInfo.model,
          "Android",
          androidDeviceInfo.version.sdkInt.toString(),
          androidDeviceInfo.isPhysicalDevice,
          androidDeviceInfo.androidId);
    }
  }
}

class _DeviceInfo {
  ///手机名
  final String name;

  ///系统名
  final String systemName;

  ///系统版本,安卓这里用的是sdkint
  final String systemVersion;

  ///是否是真机
  final bool isPhysicalDevice;

  ///唯一标识
  final String identifierForVendor;

  _DeviceInfo(this.name, this.systemName, this.systemVersion,
      this.isPhysicalDevice, this.identifierForVendor);

  @override
  String toString() {
    return "name:" +
        "$name\n" +
        "model:" +
        "systemName:" +
        "$systemName\n" +
        "systemVersion:" +
        "$systemVersion\n" +
        "isPhysicalDevice:" +
        "$isPhysicalDevice\n" +
        "identifierForVendor:" +
        "$identifierForVendor\n";
  }
}
