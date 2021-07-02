// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel()
    ..uid = json['doc_id'] as String
    ..nama = json['nama'] as String
    ..email = json['email'] as String
    ..noTelp = json['noTelp'] as String
    ..alamat = json['alamat'] as String
    ..profileUrl = json['profile_url'] as String;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'doc_id': instance.uid,
      'nama': instance.nama,
      'email': instance.email,
      'noTelp': instance.noTelp,
      'alamat': instance.alamat,
      'profile_url': instance.profileUrl,
    };
