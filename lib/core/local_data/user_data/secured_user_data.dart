import 'package:breach/core/constants/local_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';


abstract class SecuredUserData {
  Future<void> saveUserData({
    required String id,
    required String name,
    required String email,
  });

  Future<SecuredUser> getUserData();

  Future<void> clearUserData();
}

@LazySingleton(as: SecuredUserData)
class SecuredUserDataImpl implements SecuredUserData {
  SecuredUserDataImpl(this.flutterSecureStorage);
  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<void> saveUserData({
    required String id,
    required String name,
    required String email,
  }) async {
    await flutterSecureStorage.write(key: userIdKey, value: id);
    await flutterSecureStorage.write(key: userNameKey, value: name);
    await flutterSecureStorage.write(key: userEmailKey, value: email);

  }

  @override
  Future<SecuredUser> getUserData() async {
    return SecuredUser(
      id: await flutterSecureStorage.read(key: userIdKey),
      name: await flutterSecureStorage.read(key: userNameKey),
      email: await flutterSecureStorage.read(key: userEmailKey),
    );
  }

  @override
  Future<void> clearUserData() async {
    await flutterSecureStorage.deleteAll();
  }
}

class SecuredUser {
  SecuredUser({this.id, this.name,  this.email });

  final String? id;
  final String? name;
  final String? email;


}
