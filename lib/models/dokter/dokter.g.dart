// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dokter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dokter _$DokterFromJson(Map<String, dynamic> json) {
  return Dokter()
    ..uid = json['doc_id'] as String
    ..nama = json['nama'] as String
    ..email = json['email'] as String
    ..noTelp = json['noTelp'] as String
    ..alamat = json['alamat'] as String
    ..jenisKelamin = json['jenis_kelamin'] as String
    ..noSIP = json['no_sip'] as String
    ..spesialis = json['spesialis'] as String
    ..noRek = json['no_rek'] as String
    ..profileUrl = json['profile_url'] as String
    ..isBusy = json['is_busy'] as bool;
}

Map<String, dynamic> _$DokterToJson(Dokter instance) => <String, dynamic>{
      'doc_id': instance.uid,
      'nama': instance.nama,
      'email': instance.email,
      'noTelp': instance.noTelp,
      'alamat': instance.alamat,
      'jenis_kelamin': instance.jenisKelamin,
      'no_sip': instance.noSIP,
      'spesialis': instance.spesialis,
      'no_rek': instance.noRek,
      'profile_url': instance.profileUrl,
      'is_busy': instance.isBusy,
    };
