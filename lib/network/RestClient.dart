import 'package:demoflutterloginlogout/model/jobModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'RestClient.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @GET("users")
  Future<List<Job>> getTasks();
}
