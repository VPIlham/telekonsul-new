// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaksi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaksi _$TransaksiFromJson(Map<String, dynamic> json) {
  return Transaksi()
    ..docId = json['doc_id'] as String
    ..dokterProfile = json['dokter_profile'] == null
        ? null
        : Dokter.fromJson(json['dokter_profile'] as Map<String, dynamic>)
    ..jadwalKonsultasi = json['jadwal_konsultasi'] == null
        ? null
        : JadwalKonsultasi.fromJson(
            json['jadwal_konsultasi'] as Map<String, dynamic>)
    ..status = json['status'] as String
    ..buktiPembayaran = json['bukti_pembayaran'] as String
    ..createdAt = Transaksi._fromJson(json['created_at'] as Timestamp)
    ..createdBy = json['created_by'] == null
        ? null
        : UserModel.fromJson(json['created_by'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TransaksiToJson(Transaksi instance) => <String, dynamic>{
      'doc_id': instance.docId,
      'dokter_profile': instance.dokterProfile,
      'jadwal_konsultasi': instance.jadwalKonsultasi,
      'status': instance.status,
      'bukti_pembayaran': instance.buktiPembayaran,
      'created_at': Transaksi._toJson(instance.createdAt),
      'created_by': instance.createdBy,
    };
