import 'dart:io';

import 'package:breach/core/constants/api_base_url.dart';
import 'package:breach/core/logger/app_logger.dart';
import 'package:breach/core/network/info/network_info.dart';
import 'package:breach/core/network/interceptors/content_type_interceptor.dart';
import 'package:breach/core/network/interceptors/token_interceptor.dart';
import 'package:breach/core/utils/internet_safe_runner.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';



class DioSetup {
  static Dio initializeDio(Dio dioInstance,
      NetworkInfo networkInfo, FlutterSecureStorage secureStorage,) {
    dioInstance.options = BaseOptions(
      contentType: 'application/json',
    );
    dioInstance.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        filter: (options, args) => !args.isResponse
            || !args.hasUint8ListData,
      ),
      RetryInterceptor(
        dio: dioInstance,
        logPrint: print,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
      ContentTypeInterceptor(),
      TokenInterceptor(dioInstance, secureStorage),
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          AppLogger.d('Dio error intercepted: $error');
          return handler.next(error);
        },
      ),
    ],);

    (dioInstance.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()..badCertificateCallback = (cert, host, port) => true;

    return dioInstance;
  }

  static T initializeApiClient<T>(
      Dio dioInstance,
      T Function(Dio dio, {required String baseUrl}) clientFactory,
      ) {
    return clientFactory(dioInstance, baseUrl: EnvConstants.baseUrl);
  }

  static InternetSafeRunner initializeInternetSafeRunner(NetworkInfo networkInfo) {
    return InternetSafeRunner(networkInfo);
  }
}

