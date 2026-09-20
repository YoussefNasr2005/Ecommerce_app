import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final List<String> categories;
  const CategoriesLoadedState(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoriesErrorState extends CategoriesState {
  final String errorMessage;
  const CategoriesErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
