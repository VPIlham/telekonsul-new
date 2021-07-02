// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'antrian.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Antrian _$AntrianFromJson(Map<String, dynamic> json) {
  return Antrian()
    ..docId = json['doc_id'] as String
    ..dataTransaksi = json['data_transaksi'] == null
        ? null
        : Transaksi.fromJson(json['data_transaksi'] as Map<String, dynamic>)
    ..nomorAntrian = json['nomor_antrian'] as int
    ..isDone = json['is_done'] as bool
    ..createdAt = Antrian._fromJson(json['created_at'] as Timestamp);
}

Map<String, dynamic> _$AntrianToJson(Antrian instance) => <String, dynamic>{
      'doc_id': instance.docId,
      'data_transaksi': instance.dataTransaksi,
      'nomor_antrian': instance.nomorAntrian,
      'is_done': instance.isDone,
      'created_at': Antrian._toJson(instance.createdAt),
    };
