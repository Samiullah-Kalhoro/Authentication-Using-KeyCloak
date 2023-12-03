import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = 'http://192.168.38.244:8080';
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
} 

