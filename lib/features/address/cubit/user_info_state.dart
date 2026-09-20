import 'package:ecommerce_app/features/address/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object?> get props => [];
}

class UserInfoInitialState extends UserInfoState {
  const UserInfoInitialState();
}

class UserInfoLoadingState extends UserInfoState {
  const UserInfoLoadingState();
}

class UserInfoLoadedState extends UserInfoState {
  final UserModel userModel;
  const UserInfoLoadedState({required this.userModel});
  @override
  List<Object?> get props => [userModel];
}

class UserInfoErrorState extends UserInfoState {
  final String errorMessage;
  const UserInfoErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
