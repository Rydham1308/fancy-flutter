import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    const baseUrl = 'https://api.postalpincode.in/pincode/';

    final BaseOptions options = BaseOptions(
        sendTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        baseUrl: baseUrl,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    _dio = Dio(options);
  }

  Dio getDio() => _dio;

}
