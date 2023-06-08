import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel {
   
  @JsonKey(name : 'id')
  final String idUser;

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'alamat')
  final String alamat;

  @JsonKey(name: 'no_telepon')
  final String noTelepon;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'scope')
  final String scope;

  @JsonKey(name: 'created_at')
  final String createdAt;

  UserModel({
    required this.idUser,
    required this.namaLengkap,
    required this.username,
    required this.alamat,
    required this.noTelepon,
    required this.password,
    required this.scope,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String,dynamic> json) {
    return UserModel(
      idUser: json['id'] as String,
      namaLengkap: json['nama_lengkap'] as String,
      username: json['username'] as String,
      alamat : json['alamat'] as String,
      noTelepon: json['no_telepon'] as String,
      password: json['password'] as String,
      scope: json['scope'] as String,
      createdAt: json['created_at'] as String,
    );
  }
}