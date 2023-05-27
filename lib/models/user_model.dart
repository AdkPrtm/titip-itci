part of 'models.dart';

class UserModel {
  final String nama, email, token;

  UserModel({
    required this.nama,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nama: json['nama'],
        email: json['email'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() {
    return {
      'nama': this.nama,
      'email': this.email,
      'token': this.token,
    };
  }
}
