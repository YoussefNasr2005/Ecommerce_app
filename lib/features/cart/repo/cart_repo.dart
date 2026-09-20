import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/cart/models/cart_model.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';

class CartRepo {
  final DioHelper _dioHelper;
  CartRepo(this._dioHelper);

  Future<Either<String, CartModel>> getUserCart() async {
    try {
      final res =
          await _dioHelper.getRequest(endPoint: '${ApiEndpoints.carts}/user/2');
      if (res.statusCode == 200) {
        final data = res.data['carts'];
        if (data is List && data.isEmpty) {
          return const Left('Cart is empty');
        }

        final Map<String, dynamic> cartJson = (data is List)
            ? Map<String, dynamic>.from(data.first as Map)
            : Map<String, dynamic>.from(data as Map);

        final cart = CartModel.fromJson(cartJson);

        return Right(cart);
      } else {
        return const Left('Error in getting cart');
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

  Future<Either<String, CartModel>> updateUserCart(
      {required String date,
      required Product product,
      required int quantity}) async {
    try {
      final res = await _dioHelper.putRequest(
        endPoint: '${ApiEndpoints.carts}/3',
        //ثبتنا هنا اليوزر ودا غلط لان كده اي حد معاه الايدي بتاعك هيجيب
        // نفس الكارتس مفروض المعلومات اللي زي دي تتربط بالتوكن
        data: {
          'merge':true,
          'products': [
            {'productId': product.id, 'quantity': quantity},
          ]
        },
      );
      if (res.statusCode == 200) {
        final CartModel cartModel = CartModel.fromJson(res.data);
        return Right(cartModel);
      } else {
        return const Left('Error in getting cart');
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
