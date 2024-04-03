import 'package:dio/dio.dart';

class ApiServices {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://flutter.prominaagency.com/api/',
      ),
    );
  }

  Future<dynamic> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    var response = await dio.get(
      path,
      queryParameters: query,
    );
    return response.data;
  }

  Future<Response> postData({
    required String path,
    required dynamic data,
    String? token,
  }) async {
    token != null
        ? dio.options.headers = {
            'Content-Type': 'multipart/form-data',
            "Authorization": "Bearer $token",
          }
        : {
            'Content-Type': 'multipart/form-data',
          };
    return await dio.post(
      path,
      data: data,
    );
  }

  Future<Response> putData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    return await dio.put(
      path,
      data: data,
    );
  }
}
