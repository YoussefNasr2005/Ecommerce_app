import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/home_screen/models/categories_model.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';

class HomeRepo {
  final DioHelper _dioHelper;
  HomeRepo(this._dioHelper);

  Future<Either<String, ProductsModel>> getProducts() async {
    try {
      final response =
          await _dioHelper.getRequest(endPoint: ApiEndpoints.products);
      if (response.statusCode == 200) {
        ProductsModel products = ProductsModel.fromJson(response.data);
        return Right(products);
      } else {
        return const Left('Somthing went wrong!');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'Server Error')
          : (e.response?.data?.toString() ?? e.message ?? 'Network Error');
      return left(errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ProductsModel>> getProductCategories(
      {required String categoryName}) async {
    try {
      final response = await _dioHelper.getRequest(
          endPoint:
              '${ApiEndpoints.products}/${ApiEndpoints.catProducts}/$categoryName');
      if (response.statusCode == 200) {
        ProductsModel categories = ProductsModel.fromJson(response.data);

        return Right(categories);
      } else {
        return const Left('Somthing went wrong!');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'Server Error')
          : (e.response?.data?.toString() ?? e.message ?? 'Network Error');
      return left(errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<String>>> getCategories() async {
    try {
      final response =
          await _dioHelper.getRequest(endPoint: ApiEndpoints.categories);
      if (response.statusCode == 200) {
        List<String> categories = categorisModelFromJson(response.data);
        categories.insert(0, 'All');
        return Right(categories);
      } else {
        return const Left('Somthing went wrong!');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'Server Error')
          : (e.response?.data?.toString() ?? e.message ?? 'Network Error');
      return left(errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ProductsModel>> searchByWord(String query) async {
    try {
      final response = await _dioHelper.getRequest(
          endPoint: ApiEndpoints.search, queryParameters: {'q': query});
      if (response.statusCode == 200) {
        final ProductsModel products = ProductsModel.fromJson(response.data);
        return Right(products);
      } else {
        return const Left('Somthing went wrong!');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'Server Error')
          : (e.response?.data?.toString() ?? e.message ?? 'Network Error');
      return left(errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }
}
