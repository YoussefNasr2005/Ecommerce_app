import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/utils/local_storage/storage_helper.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/address/model/user_model.dart';

class UserRepo {
  final DioHelper _dioHelper;
  UserRepo(this._dioHelper);

  Future<Either<String, UserModel>> getUserInfo() async {
    try {
      final token = await sl<StorageHelper>().getToken();
      if (token == null || token.isEmpty) {
        return const Left('Token Is Missing Or Expired');
      }
      final res = await _dioHelper.getRequest(
        endPoint: ApiEndpoints.userInfo,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final userModel = UserModel.fromJson(res.data);

        return Right(userModel);
      } else {
        return const Left('Error in getting data');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? (e.response?.data['message']) ?? ('Server Error')
          : (e.response?.data.toString() ?? e.message ?? 'Error in Network');

      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
