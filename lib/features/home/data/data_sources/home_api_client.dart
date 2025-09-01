import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';

@RestApi()
abstract class HomeApiClient {
  factory HomeApiClient(Dio dio, {String baseUrl})
  = _HomeApiClient;


  @GET('/blog/categories')
  Future<HttpResponse> getCategories();


  @GET('/blog/posts')
  Future<HttpResponse> getPosts({
    @Query('category') String? category,
  });


  @GET('/users/{id}/interests')
  Future<HttpResponse> getUserInterests({
    @Header('Authorization') required String token,
    @Path('id') required String userId,
   });


  @POST('/users/{id}/interests')
  Future<HttpResponse> saveUserInterests({
    @Header('Authorization') required String token,
    @Path('id')  required String userId,
    @Body() required Map<String, dynamic> body,
  });
}
