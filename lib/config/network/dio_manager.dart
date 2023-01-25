import 'package:dio/dio.dart';

class DioManager {
  static DioInstance get instance => DioInstance();
}

class DioInstance {
  factory DioInstance() => _dioInstance ??= const DioInstance._();

  const DioInstance._();

  static DioInstance? _dioInstance;

  Dio get dio => _dio ??= _newDio();

  static Dio? _dio;

  Dio _newDio() {
    const String baseUrl = "https://newz.bbear.kr/api";

    var baseOption = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 12000,
      receiveTimeout: 10000,
    );

    return Dio(baseOption);
  }
}
