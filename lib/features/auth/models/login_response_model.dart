class LoginResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final int? id;
  final String? username;
  final String? email;

  LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.username,
    this.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
