import 'package:json_annotation/json_annotation.dart';
import 'package:telekonsul/models/jadwal_konsultasi/jadwal_konsultasi.dart';

part 'dokter.g.dart';

@JsonSerializable()
class Dokter {
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

  @JsonKey(name: "jenis_kelamin")
  String jenisKelamin;

  @JsonKey(name: "no_sip")
  String noSIP;

  @JsonKey(name: "spesialis")
  String spesialis;

  @JsonKey(name: "no_rek")
  String noRek;

  @JsonKey(name: "profile_url")
  String profileUrl;

  @JsonKey(name: "is_busy")
  bool isBusy;

  Dokter();

  factory Dokter.fromJson(Map<String, dynamic> json) => _$DokterFromJson(json);
  Map<String, dynamic> toJson() => _$DokterToJson(this);
}

class DataDokter {
  Dokter dokter;

  List<JadwalKonsultasi> jadwalKonsultasi;

  bool isBooked;

  DataDokter();
}
