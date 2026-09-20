class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String username;
  final String image;
  final AddressModel? address;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.image,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      username: json['username'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] != null
          ? AddressModel.fromJson(Map<String, dynamic>.from(json['address']))
          : null);
}

class AddressModel {
  final String address;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final String country;

  AddressModel({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        address: json['address'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        stateCode: json['stateCode'] ?? '',
        postalCode: json['postalCode'] ?? '',
        country: json['country'] ?? '',
      );
}
