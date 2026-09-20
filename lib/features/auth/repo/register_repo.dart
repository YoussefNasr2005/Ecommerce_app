import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/auth/models/register_resoponse_model.dart';

class RegisterRepo {
  final DioHelper _dioHelper;
  RegisterRepo(this._dioHelper);

  Future<Either<String, RegisterResponseModel>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioHelper.postRequest(
        endPoint: ApiEndpoints.register,
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final registerResponseModel =
            RegisterResponseModel.fromJson(response.data);
        return Right(registerResponseModel);
      } else {
        return Left('Failed to register user: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final String errorMessage = e.response?.data?['message']?.toString() ??
          e.message ??
          'An unexpected network error occurred';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
