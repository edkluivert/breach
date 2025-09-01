import 'package:breach/core/constants/local_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';


// ignore: one_member_abstracts
abstract class GetLoggedInUserToken {
  Future<String?> call();
}

@LazySingleton(as: GetLoggedInUserToken)
class GetLoggedInUserTokenImpl implements GetLoggedInUserToken {
  GetLoggedInUserTokenImpl(this.flutterSecureStorage);
  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<String?> call() async {
    return flutterSecureStorage.read(key: loggedInUserToken);
  }
}
