import 'package:dio/dio.dart';


class ContentTypeInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    options.contentType = 'application/json';
    return handler.next(options);
  }


  @override
  void onResponse(
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
      ) {
    handler.next(response);
  }

}