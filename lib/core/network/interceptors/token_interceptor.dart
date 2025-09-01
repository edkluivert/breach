import 'package:breach/core/constants/local_data.dart';
import 'package:breach/core/injections/injection.dart';
import 'package:breach/core/logger/app_logger.dart';
import 'package:breach/core/navigation/navigation_service.dart';
import 'package:breach/core/navigation/route_paths.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor(this.dio, this.secureStorage,);
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorage.read(key: loggedInUserToken);


    final authToken = token;

    if (authToken != null) {
      if (JwtDecoder.isExpired(authToken)) {
        AppLogger.d('Token has expired. Logging out.');
        await secureStorage.delete(key: loggedInUserToken);
        await sl<NavigationService>().removeAllAndNavigateTo(Routes.login);
        return;
      }

      options.headers['Authorization'] = 'Bearer $authToken';
    }

    return handler.next(options);
  }


  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      AppLogger.e('401 Unauthorized. Kicking user out.');

      await secureStorage.delete(key: loggedInUserToken);
      await sl<NavigationService>().removeAllAndNavigateTo(Routes.login);
      return;
    }

    AppLogger.e('Unhandled Dio error: $err');
    return handler.next(err);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
