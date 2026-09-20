abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoginState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}

class AuthSuccessState extends AuthState {
  final String successMessage;
  AuthSuccessState(this.successMessage);
}
