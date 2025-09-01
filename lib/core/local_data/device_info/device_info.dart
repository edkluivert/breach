import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceInfo {
  Future<String> getDeviceName();
  Future<String> getDeviceId();
  Future<String> getDeviceIp();
}

@LazySingleton(as: DeviceInfo)
class DeviceInformation implements DeviceInfo {
  DeviceInformation(
    this.deviceInfoPlugin,
    this.ipify,
  );
  final DeviceInfoPlugin deviceInfoPlugin;
  final Ipify ipify;

  @override
  Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return '${androidInfo.manufacturer}  ${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return '${iosInfo.utsname.machine} ${iosInfo.model}';
    } else {
      return '';
    }
  }

  @override
  Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    }

    final iosInfo = await deviceInfoPlugin.iosInfo;
    return '${iosInfo.identifierForVendor}';
  }

  @override
  Future<String> getDeviceIp() async {
    return '127.0.0.1';
  }
}
