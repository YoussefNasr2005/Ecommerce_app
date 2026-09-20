import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/local_storage/storage_helper.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/auth/repo/auth_repo.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_state.dart';
import 'package:ecommerce_app/features/auth/models/login_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitialState());

  final AuthRepo _authRepo;

  void login({required String username, required String password}) async {
    emit(AuthLoginState());
    final Either<String, LoginResponseModel> res =
        await _authRepo.login(username, password);

    res.fold((errorMessage) {
      emit(AuthErrorState(errorMessage));
    }, (success) {
      emit(AuthSuccessState('Login Successfully'));
    });
  }

  Future<void> logOut() async {
    await sl<StorageHelper>().clearAll();
  }
}
