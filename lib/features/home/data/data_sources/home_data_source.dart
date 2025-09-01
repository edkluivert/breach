import 'package:breach/core/error/error.dart';
import 'package:breach/core/local_data/user_data/secured_user_data.dart';
import 'package:breach/core/local_data/user_token/get_user_logged_in_token.dart';
import 'package:breach/core/network/base/dio_setup.dart';
import 'package:breach/core/network/info/network_info.dart';
import 'package:breach/core/utils/internet_safe_runner.dart';
import 'package:breach/features/home/data/data_sources/home_api_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class HomeRemoteDataSource {

  Future<List<dynamic>> getPosts(String? category);

  Future<List<dynamic>>  getCategories();

  Future<List<dynamic>> getUserInterests();

  Future<bool> saveUserInterests({
    required List<String> categoryIds
  });

}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {

  HomeRemoteDataSourceImpl({
    required Dio dio,
    required this.networkInfo,
    required this.getLoggedInUserToken,
    required this.securedUserData,
    required this.internetSafeRunner,
  }) : homeApiClient = DioSetup.initializeApiClient(dio, (d,
      {required baseUrl,}) => HomeApiClient(d, baseUrl: baseUrl),);

  final HomeApiClient homeApiClient;
  final InternetSafeRunner internetSafeRunner;
  final GetLoggedInUserToken getLoggedInUserToken;
  final SecuredUserData securedUserData;
  final NetworkInfo networkInfo;

  @override
  Future<List<dynamic>> getCategories() async {
    if (await networkInfo.isConnected) {
      final result = await homeApiClient.getCategories();
      return result.response.data as List<dynamic>;
    } else {
      throw AppException('No Internet Connection');
    }
  }

  @override
  Future<List<dynamic>> getPosts(String? category) async {
    if (await networkInfo.isConnected) {
      final result = await homeApiClient.getPosts(category: category);
      return result.response.data as List<dynamic>;
    } else {
      throw AppException('No Internet Connection');
    }
  }

  @override
  Future<List<dynamic>> getUserInterests() async {
    if (await networkInfo.isConnected) {
      final token = await getLoggedInUserToken();
      final userId = await securedUserData.getUserData();
      final result = await homeApiClient.getUserInterests(
          token: token??'',
        userId: userId.id??'',
      );
      return result.response.data as List<dynamic>;
    } else {
      throw AppException('No Internet Connection');
    }
  }

  @override
  Future<bool> saveUserInterests({required List<String> categoryIds}) async {
    if (await networkInfo.isConnected) {
      final body = {
        'interests': categoryIds,
      };
      final token = await getLoggedInUserToken();
      final userId = await securedUserData.getUserData();
      final result = await homeApiClient.saveUserInterests(
        token: token??'',
        userId: userId.id??'',
        body:  body,
      );
      return result.response.statusCode == 200;
    } else {
      throw AppException('No Internet Connection');
    }
  }


}