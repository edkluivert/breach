import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(
    this.dataConnectionChecker,
  );

  final InternetConnection dataConnectionChecker;

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasInternetAccess;
}
