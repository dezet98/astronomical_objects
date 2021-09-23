import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://apodapi.herokuapp.com/api/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("")
  Future<List<AstronomicalObject>> getAstronomicalObjects(
      {@Query("count") int count = 20, @Query("thumbs") bool thumbs = true});
}
