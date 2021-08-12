import 'package:dio/dio.dart';

class DioService {
  static Dio? dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getResponse(
      {required String url,
      Map<String, dynamic> queryParameters = const {'': ''},
      String lang = 'en',
      String? token = ''}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio!.get(url, queryParameters: queryParameters);
  }

  static Future<Response> postResponseUrl({required String url, data}) async {
    return await dio!.post(url, data: data);
  }

  static Future<Response> postResponse(
      {required String url, data, Map<String, dynamic> query = const {'': ''},
      String lang = 'en', String? token = ''}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json', 'lang': lang, 'Authorization': token
    };
    return await dio!.post(url, data: data, queryParameters: query);
  }
}
