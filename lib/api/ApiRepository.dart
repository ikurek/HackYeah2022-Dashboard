import 'package:dio/dio.dart';
import 'package:admin/models/Post.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String PARAM_SMART_SEARCH_QUERY = "smart_search_query";
const String PARAM_KEYWORD = "keyword";
const String PARAM_AUTHOR_USERNAME = "author_username";
const String PARAM_FROM_DATE = "from_date";
const String PARAM_TO_DATE = "to_date";

class ApiRepository {
  static Dio dio = Dio(BaseOptions(baseUrl: "http://local.domain.com:5000/"));

  static setup() {
    dio.interceptors.add(PrettyDioLogger(responseBody: false));
  }

  static Future<List<Post>> getPosts(
      {DateTime? from = null, DateTime? to = null}) async {
    Response response = await dio.get("posts", queryParameters: {
      PARAM_FROM_DATE: (from?.toIso8601String() ?? ''),
      PARAM_TO_DATE: (to?.toIso8601String() ?? '')
    });
    return (response.data as List).map((post) => Post.fromJson(post)).toList();
  }

  static Future<Post> getPost(int id) async {
    Response response = await dio.get("posts/$id");
    return Post.fromJson(response.data);
  }

  static Future<List<Post>> searchPosts(
      {String? smartSearchQuery = null,
      String? keyword = null,
      String? authorUsername = null,
      DateTime? from = null,
      DateTime? to = null}) async {
    Response response = await dio.get("search", queryParameters: {
      PARAM_SMART_SEARCH_QUERY: (smartSearchQuery ?? ''),
      PARAM_KEYWORD: (keyword ?? ''),
      PARAM_AUTHOR_USERNAME: (authorUsername ?? ''),
      PARAM_FROM_DATE: (from?.toIso8601String() ?? ''),
      PARAM_TO_DATE: (to?.toIso8601String() ?? '')
    });
    return (response.data as List).map((post) => Post.fromJson(post)).toList();
  }
}
