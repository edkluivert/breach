
import 'package:breach/core/error/error.dart';
import 'package:breach/core/error/failure.dart';
import 'package:breach/core/extensions/other_extensions.dart';
import 'package:breach/core/local_data/user_data/secured_user_data.dart';
import 'package:breach/core/local_data/user_token/get_user_logged_in_token.dart';
import 'package:breach/core/local_data/user_token/set_user_logged_in_token.dart';
import 'package:breach/core/logger/app_logger.dart';
import 'package:breach/core/network/base/dio_setup.dart';
import 'package:breach/core/network/info/network_info.dart';
import 'package:breach/core/utils/internet_safe_runner.dart';
import 'package:breach/features/authentication/data/data_sources/auth_api_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


abstract class AuthRemoteDataSource {

  Future<bool> login({
    required String email,
    required String password,
  });

  Future<bool> register({
    required String email,
    required String password,
  });

}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl({
    required Dio dio,
    required this.networkInfo,
    required this.getLoggedInUserToken,
    required this.saveLoggedInUserToken,
    required this.securedUserData,
    required this.internetSafeRunner,
  }) : authApiClient = DioSetup.initializeApiClient(dio, (d,
      {required baseUrl,}) => AuthApiClient(d, baseUrl: baseUrl),);

  final AuthApiClient authApiClient;
  final InternetSafeRunner internetSafeRunner;
  final GetLoggedInUserToken getLoggedInUserToken;
  final SaveLoggedInUserToken saveLoggedInUserToken;
  final SecuredUserData securedUserData;
  final NetworkInfo networkInfo;



  @override
  Future<bool> login({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      final body = {
        'email': email,
        'password': password,
      };


      final result = await handleApiCall(() async {
        return  authApiClient.login(body: body);
      });

      final data = result.response.data as Map<String, dynamic>;
      final accessToken = data['token'] as String;
      await saveLoggedInUserToken.call(accessToken);
      await securedUserData.saveUserData(
        id: data['userId'].toString(),
        name: email.username,
        email: email,
      );
      AppLogger.d('this is the token $accessToken');

      return result.response.statusCode == 200;
    } else {
      throw AppException('No internet connection');
    }
  }

  @override
  Future<bool> register({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      final body = {
        'email': email,
        'password': password,
      };


      final result = await handleApiCall(() async {
        return  authApiClient.register(body: body);
      });

      final data = result.response.data as Map<String, dynamic>;
      final accessToken = data['token'] as String;
      await saveLoggedInUserToken.call(accessToken);
      await securedUserData.saveUserData(
        id: data['userId'].toString(),
        name: email.username,
        email: email,
      );
      AppLogger.d('this is the token $accessToken');

      return result.response.statusCode == 200;
    } else {
      throw AppException('No internet connection');
    }
  }

}