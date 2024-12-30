import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tender/core/network/models/api_response.model.dart';

part 'newspaper.api.g.dart';

@RestApi()
abstract class NewsPaperApi {
  factory NewsPaperApi(Dio dio, {String baseUrl}) = _NewsPaperApi;

  @GET('/news-paper')
  Future<PaginatedDataResponse> getNewspapers();

  @POST('/news-paper')
  @MultiPart()
  Future<DataResponse> createNewspaper(
      @Part() Map<String, dynamic> body);

  @PATCH('/news-paper/{id}')
  Future<DataResponse> updateNewspaper(
    @Path('id') String id,
    @Part() Map<String, dynamic> body,
  );

  @DELETE('/news-paper/{id}')
  Future<MessageResponse> deleteNewspaper(@Path('id') String id);
}
