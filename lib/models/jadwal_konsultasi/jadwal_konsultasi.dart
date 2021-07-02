import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'jadwal_konsultasi.g.dart';

@JsonSerializable()
class JadwalKonsultasi {
  @JsonKey(name: "doc_id")
  String docId;

  @JsonKey(name: "hari", toJson: _hariToJson)
  Hari hari;

  @JsonKey(name: "jam_mulai", fromJson: _fromJson, toJson: _toJson)
  TimeOfDay jamMulai;

  @JsonKey(name: "jam_akhir", fromJson: _fromJson, toJson: _toJson)
  TimeOfDay jamAkhir;

  @JsonKey(name: "harga")
  double harga;

  JadwalKonsultasi();

  factory JadwalKonsultasi.fromJson(Map<String, dynamic> json) =>
      _$JadwalKonsultasiFromJson(json);
  Map<String, dynamic> toJson() => _$JadwalKonsultasiToJson(this);

  static TimeOfDay _fromJson(String jam) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(jam));
  }

  static String _toJson(TimeOfDay jam) => jam.toString();

  static Map<String, dynamic> _hariToJson(Hari hari) => hari.toJson();
}

@JsonSerializable()
class Hari {
  @JsonKey(name: "day")
  String day;

  @JsonKey(name: "int_value")
  int intValue;

  Hari(this.day, this.intValue);

  factory Hari.fromJson(Map<String, dynamic> json) => _$HariFromJson(json);
  Map<String, dynamic> toJson() => _$HariToJson(this);
}
