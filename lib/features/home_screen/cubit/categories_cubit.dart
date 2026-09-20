import 'package:ecommerce_app/features/home_screen/cubit/categories_state.dart';
import 'package:ecommerce_app/features/home_screen/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final HomeRepo _homeRepo;
  CategoriesCubit(this._homeRepo) : super(CategoriesInitialState());

  Future<void> featchCategories() async {
    emit(CategoriesLoadingState());

    final res = await _homeRepo.getCategories();

    res.fold((errorMessage) => emit(CategoriesErrorState(errorMessage)),
        (response) => emit(CategoriesLoadedState(response)));
  }
}
