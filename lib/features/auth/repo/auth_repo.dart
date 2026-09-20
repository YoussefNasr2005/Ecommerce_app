import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/utils/local_storage/storage_helper.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/auth/models/login_response_model.dart';

class AuthRepo {
  final DioHelper _dioHelper;
  AuthRepo(this._dioHelper);

  Future<Either<String, LoginResponseModel>> login(
      String username, String password) async {
    try {
      final response = await _dioHelper.postRequest(
        endPoint: ApiEndpoints.login,
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(response.data);

        if (loginResponseModel.accessToken != null) {
          await sl<StorageHelper>().saveToken(loginResponseModel.accessToken!);

          if (loginResponseModel.refreshToken != null) {
            await sl<StorageHelper>()
                .saveRefreshToken(loginResponseModel.refreshToken!);
          }
          return right(loginResponseModel);
        } else {
          return left('Token Is Null');
        }
      } else {
        return Left('فشل تسجيل الدخول: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data.toString() ?? e.message ?? 'حدث خطاء بالشبكة';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> refreshTokens() async {
    try {
      final currentRefreshToken = await sl<StorageHelper>().getRefreshToken();

      if (currentRefreshToken == null) {
        return left('No Refresh Token Found');
      }
      final response = await _dioHelper.postRequest(
        endPoint: ApiEndpoints.refreshToken,
        data: {
          'refreshToken': currentRefreshToken,
          'expiresInMins': 30,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        await sl<StorageHelper>().saveToken(newAccessToken);

        if (newRefreshToken != null) {
          await sl<StorageHelper>().saveRefreshToken(newRefreshToken);
        }

        return Right(newAccessToken);
      } else {
        return const Left('Failed to refresh token');
      }
    } on DioException catch (e) {
      final String errorMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'حدث خطأ بالشبكة')
          : e.message ?? 'حدث خطأ بالشبكة';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
