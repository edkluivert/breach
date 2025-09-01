// ignore_for_file: one_member_abstracts

import 'package:breach/core/constants/local_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class SaveFirstTime {
  Future<void> call(String key);
}

@LazySingleton(as: SaveFirstTime)
class SaveFirstTimeImpl implements SaveFirstTime {
  SaveFirstTimeImpl(
    this.flutterSecureStorage,
  );
  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<void> call(String key) {
    return flutterSecureStorage.write(
      key: firstTimeUser,
      value: key,
    );
  }
}
