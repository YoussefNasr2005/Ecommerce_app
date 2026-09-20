import 'package:ecommerce_app/features/home_screen/cubit/products_state.dart';
import 'package:ecommerce_app/features/home_screen/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final HomeRepo _homeRepo;
  ProductsCubit(this._homeRepo) : super(ProductsInitialState());

  Future<void> fetchProducts() async {
    emit(ProductsLoadinState());

    final res = await _homeRepo.getProducts();
    res.fold((errorMessage) => emit(ProductsErrorState(errorMessage)),
        (response) => (emit(ProductsLoadedState(response))));
  }

  Future<void> fetchProductsCategories(String categoryName) async {
    emit(ProductsLoadinState());

    final res =
        await _homeRepo.getProductCategories(categoryName: categoryName);
    res.fold((errorMessage) => emit(ProductsErrorState(errorMessage)),
        (response) => (emit(ProductsLoadedState(response))));
  }

  
}
