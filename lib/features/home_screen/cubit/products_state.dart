import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitialState extends ProductsState {}

class ProductsLoadinState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final ProductsModel products;
  const ProductsLoadedState(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductsErrorState extends ProductsState {
  final String errorMessage;
  const ProductsErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
