import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/cubit/register_state.dart';
import 'package:ecommerce_app/features/auth/repo/register_repo.dart';
import 'package:ecommerce_app/features/auth/models/register_resoponse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;
  RegisterCubit(this._registerRepo) : super(RegisterInitialState());

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadState());

    final Either<String, RegisterResponseModel> response = await _registerRepo
        .register(username: username, email: email, password: password);

    response.fold((errorMessage) => emit(RegisterErorrState(errorMessage)),
        (responseModel) => emit(RegisterSuccessState(responseModel)));
  }
}
