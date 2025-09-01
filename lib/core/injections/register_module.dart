
import 'package:breach/core/network/base/dio_setup.dart';
import 'package:breach/core/network/info/network_info.dart';
import 'package:breach/core/utils/internet_safe_runner.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';


@module
abstract class RegisterModule {
  LocalAuthentication get localAuthentication => LocalAuthentication();
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
  InternetConnection get internetConnectionChecker => InternetConnection.createInstance();
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
  Ipify get ipify => Ipify();
  @lazySingleton
  Dio dio(NetworkInfo networkInfo) =>
      DioSetup.initializeDio(Dio(), networkInfo, flutterSecureStorage);
  @lazySingleton
  InternetSafeRunner runner(NetworkInfo networkInfo) =>
      DioSetup.initializeInternetSafeRunner(networkInfo);
}
