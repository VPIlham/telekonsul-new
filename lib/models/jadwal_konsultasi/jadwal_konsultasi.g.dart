// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jadwal_konsultasi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JadwalKonsultasi _$JadwalKonsultasiFromJson(Map<String, dynamic> json) {
  return JadwalKonsultasi()
    ..docId = json['doc_id'] as String
    ..hari = json['hari'] == null
        ? null
        : Hari.fromJson(json['hari'] as Map<String, dynamic>)
    ..jamMulai = JadwalKonsultasi._fromJson(json['jam_mulai'] as String)
    ..jamAkhir = JadwalKonsultasi._fromJson(json['jam_akhir'] as String)
    ..harga = (json['harga'] as num)?.toDouble();
}

Map<String, dynamic> _$JadwalKonsultasiToJson(JadwalKonsultasi instance) =>
    <String, dynamic>{
      'doc_id': instance.docId,
      'hari': JadwalKonsultasi._hariToJson(instance.hari),
      'jam_mulai': JadwalKonsultasi._toJson(instance.jamMulai),
      'jam_akhir': JadwalKonsultasi._toJson(instance.jamAkhir),
      'harga': instance.harga,
    };

Hari _$HariFromJson(Map<String, dynamic> json) {
  return Hari(
    json['day'] as String,
    json['int_value'] as int,
  );
}

Map<String, dynamic> _$HariToJson(Hari instance) => <String, dynamic>{
      'day': instance.day,
      'int_value': instance.intValue,
    };
