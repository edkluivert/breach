// ignore_for_file: one_member_abstracts

import 'package:breach/core/constants/local_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class GetFirstTime {
  Future<String?> call();
}

@LazySingleton(as: GetFirstTime)
class GetFirstTimeImpl implements GetFirstTime {
  GetFirstTimeImpl(
    this.flutterSecureStorage,
  );
  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<String?> call() {
    return flutterSecureStorage.read(
      key: firstTimeUser,
    );
  }
}
