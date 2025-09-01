import 'package:breach/core/constants/local_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

// ignore: one_member_abstracts
abstract class SaveLoggedInUserToken {
  Future<void> call(String token);
  Future<void> deleteToken();
}

@LazySingleton(as: SaveLoggedInUserToken)
class SaveLoggedInUserTokenImpl implements SaveLoggedInUserToken {
  SaveLoggedInUserTokenImpl(this.flutterSecureStorage);
  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<void> call(String token) async {
    return flutterSecureStorage.write(key: loggedInUserToken, value: token);
  }

  @override
  Future<void> deleteToken() async {
    return flutterSecureStorage.delete(key: loggedInUserToken);
  }

}
