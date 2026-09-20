import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final ProductsModel productsModel;
  const SearchLoadedState(this.productsModel);

  @override
  List<Object?> get props => [productsModel];
}

class SearchErrorState extends SearchState {
  final String errorMessage;
  const SearchErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
