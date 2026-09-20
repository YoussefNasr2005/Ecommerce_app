import 'package:ecommerce_app/features/address/cubit/user_info_state.dart';
import 'package:ecommerce_app/features/address/repo/address_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final UserRepo _addressRepo;
  UserInfoCubit(this._addressRepo) : super(const UserInfoInitialState());

  Future<void> getUserAddress() async {
    emit(const UserInfoLoadingState());

    final res = await _addressRepo.getUserInfo();

    res.fold(
        (errorMessage) => emit(UserInfoErrorState(errorMessage: errorMessage)),
        (userInfo) => emit(UserInfoLoadedState(userModel: userInfo)));
  }
}
