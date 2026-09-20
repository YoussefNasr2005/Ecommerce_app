import 'package:ecommerce_app/features/search/cubit/search_state.dart';
import 'package:ecommerce_app/features/home_screen/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._homeRepo) : super(SearchInitialState());
  final HomeRepo _homeRepo;

  Future<void> searchByWord(String query) async {
    emit(SearchLoadingState());
    final res = await _homeRepo.searchByWord(query);

    res.fold((errorMessage) => emit(SearchErrorState(errorMessage)),
        (products) => emit(SearchLoadedState(products)));
  }
}
