import 'package:ecommerce_app/features/cart/models/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final CartModel cartModel;
  CartLoadedState(this.cartModel);
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}

class CartItemAddingLoadingState extends CartState {}

class CartItemAddedState extends CartState {
  final CartModel cartModel;
  CartItemAddedState(this.cartModel);
}

class CartItemAddingErrorState extends CartState {
  final String message;
  CartItemAddingErrorState(this.message);
}