class RegisterResponseModel {
  final int id;
  RegisterResponseModel({required this.id});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(id: json['id'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
