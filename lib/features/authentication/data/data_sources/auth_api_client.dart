import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(
      Dio dio, {
        String baseUrl,
      }) = _AuthApiClient;

  @POST('/auth/login/')
  Future<HttpResponse> login({
    @Body() required Map<String, dynamic> body,
  });


  @POST('/auth/register/')
  Future<HttpResponse> register({
    @Body() required Map<String, dynamic> body,
  });


}
