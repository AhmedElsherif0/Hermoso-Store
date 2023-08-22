import 'package:dio/dio.dart';

class DioService {
  static Dio? _dio = Dio();
   DioService._privateConstructor(Dio dio);
 static final DioService _dioService = DioService._privateConstructor(_dio!);
 factory DioService()=> _dioService;
  static init() {
    _dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 100000,
        receiveTimeout: 100000,
        sendTimeout: 100000,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
          'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
          'Access-Control-Allow-Credentials': true
        }));
    _dio?.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestBody: false,
      requestHeader: false,
      responseHeader: false,
      request: true,
    ));
  }

  static Future<Response?> getResponse(
      {required String url,
      Map<String, dynamic>? queryParameters,
      String? lang = 'en',
      String? authorizationToken}) async {
    _dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': authorizationToken
    };
    return await _dio?.get(url, queryParameters: queryParameters);
  }

  static Future<Response?> postResponseUrl({required String url, data}) async {
    return await _dio?.post(url, data: data);
  }

  static Future<Response?> postResponse(
      {required String url,
      data,
      Map<String, dynamic> query = const {'': ''},
      String? lang = 'en',
      String? authorizationToken}) async {
    _dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': authorizationToken
    };
    return await _dio?.post(url, data: data, queryParameters: query);
  }

  static Future<Response?> putResponse(
      {required String url,
      data,
      Map<String, dynamic> query = const {'': ''},
      String? lang = 'en',
      String? authorizationToken}) async {
    _dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': authorizationToken
    };
    return await _dio?.put(url, data: data, queryParameters: query);
  }
}
