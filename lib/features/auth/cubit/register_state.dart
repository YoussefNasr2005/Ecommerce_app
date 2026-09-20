import 'package:ecommerce_app/features/auth/models/register_resoponse_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadState extends RegisterState {}

class RegisterErorrState extends RegisterState {
  final String errorMessage;
  RegisterErorrState(this.errorMessage);
}

class RegisterSuccessState extends RegisterState {
   final RegisterResponseModel response;
    RegisterSuccessState(this.response);
}
