import 'package:ecommerce_app/features/cart/cubit/cart_state.dart';
import 'package:ecommerce_app/features/cart/repo/cart_repo.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;
  CartCubit(this._cartRepo) : super(CartInitialState());

  Future<void> fetchCarts() async {
    emit(CartLoadingState());

    final res = await _cartRepo.getUserCart();
    res.fold((errorMessage) => emit(CartErrorState(errorMessage)),
        (cart) => emit(CartLoadedState(cart)));
  }

  Future<void> addToCart(
      {required Product product, required int quantity}) async {
    final String formattedDate = DateTime.now().toIso8601String();
    emit(CartItemAddingLoadingState());
    final res = await _cartRepo.updateUserCart(
        date: formattedDate.toString(), product: product, quantity: quantity);

    res.fold((errorMessage) => emit(CartItemAddingErrorState(errorMessage)),
        (cartAdded) => emit(CartItemAddedState(cartAdded)));
  }
}
