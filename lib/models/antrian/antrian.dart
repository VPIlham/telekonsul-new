import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:telekonsul/models/transaksi/transaksi.dart';

part 'antrian.g.dart';

@JsonSerializable()
class Antrian {
  @JsonKey(name: "doc_id")
  String docId;

  @JsonKey(name: "data_transaksi")
  Transaksi dataTransaksi;

  @JsonKey(name: "nomor_antrian")
  int nomorAntrian;

  @JsonKey(name: "is_done")
  bool isDone;

  @JsonKey(name: "created_at", fromJson: _fromJson, toJson: _toJson)
  DateTime createdAt;

  Antrian();

  factory Antrian.fromJson(Map<String, dynamic> json) =>
      _$AntrianFromJson(json);
  Map<String, dynamic> toJson() => _$AntrianToJson(this);

  static DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();

  static Timestamp _toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}
