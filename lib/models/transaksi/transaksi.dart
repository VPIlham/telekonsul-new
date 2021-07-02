import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:telekonsul/models/dokter/dokter.dart';
import 'package:telekonsul/models/jadwal_konsultasi/jadwal_konsultasi.dart';
import 'package:telekonsul/models/user/user.dart';

part 'transaksi.g.dart';

@JsonSerializable()
class Transaksi {
  @JsonKey(name: "doc_id")
  String docId;

  @JsonKey(name: "dokter_profile")
  Dokter dokterProfile;

  @JsonKey(name: "jadwal_konsultasi")
  JadwalKonsultasi jadwalKonsultasi;

  @JsonKey(name: "status")
  String status;

  @JsonKey(name: "bukti_pembayaran")
  String buktiPembayaran;

  @JsonKey(name: "created_at", fromJson: _fromJson, toJson: _toJson)
  DateTime createdAt;

  @JsonKey(name: "created_by")
  UserModel createdBy;

  Transaksi();

  factory Transaksi.fromJson(Map<String, dynamic> json) =>
      _$TransaksiFromJson(json);
  Map<String, dynamic> toJson() => _$TransaksiToJson(this);

  static DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();

  static Timestamp _toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}
