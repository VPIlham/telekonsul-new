import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "doc_id")
  String uid;

  @JsonKey(name: "nama")
  String nama;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "noTelp")
  String noTelp;

  @JsonKey(name: "alamat")
  String alamat;

  @JsonKey(name: "profile_url")
  String profileUrl;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
