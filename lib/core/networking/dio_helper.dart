import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  Dio? dio;

  DioHelper() {
    dio = Dio(BaseOptions(
        baseUrl: ApiEndpoints.baseUrl, receiveDataWhenStatusError: true));
    dio!.interceptors.addAll([
      AppInterceptor(),
      PrettyDioLogger(
          requestHeader: true, requestBody: true, responseBody: true)
    ]);
  }

  Future<Response> getRequest(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final Response response = await dio!.get(endPoint,
          queryParameters: queryParameters, options: Options(headers: headers));
      return response;
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected error: $e'), stackTrace);
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic>? data,
  }) async {
    try {
      Response response = await dio!.post(endPoint, data: data);
      return response;
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected error: $e'), stackTrace);
    }
  }

  Future<Response> putRequest({
    required String endPoint,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio!.put(endPoint, data: data);
      return response;
    } on DioException {
      rethrow;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
}
