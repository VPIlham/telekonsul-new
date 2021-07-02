import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telekonsul/models/jadwal_konsultasi/jadwal_konsultasi.dart';

class JadwalKonsultasiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<JadwalKonsultasi> _listJadwalKonsultasi = [];
  List<JadwalKonsultasi> get listJadwalKonsultasi => _listJadwalKonsultasi;

  // Mengambil semua data jadwal konsultasi, dari subCollection dtoker, kemudian dimasukkan ke variabel _listJadwalKonsultasi
  getListJadwalKonsultasi(String dokterUid) async {
    _isLoading = true;
    _listJadwalKonsultasi.clear();
    await FirebaseFirestore.instance
        .doc('dokter/$dokterUid')
        .collection('jadwal_konsultasi')
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      _listJadwalKonsultasi
          .addAll(value.docs.map((e) => JadwalKonsultasi.fromJson(e.data())));
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  // Menambahkan jadwal konsultasi ke subCollection dokter
  addJadwalKonsultasi(
    Map<String, dynamic> data,
    String dokterUid,
  ) async {
    await FirebaseFirestore.instance
        .doc("dokter/$dokterUid")
        .collection('jadwal_konsultasi')
        .add(data)
        .then((value) async {
      await value.update({
        'doc_id': value.id,
      });
      return;
    });
  }


  // Mengupdate data jadwal konsultasi dokter
  updateJadwalKonsultasi(
    String docId,
    Map<String, dynamic> data,
    String dokterUid,
  ) async {
    await FirebaseFirestore.instance
        .doc('dokter/$dokterUid/jadwal_konsultasi/$docId')
        .update(data);
    return;
  }


  // Menghapus data jadwal konsultasi dokter
  deleteJadwalKonsultasi(
    String docId,
    String dokterUid,
  ) async {
    await FirebaseFirestore.instance
        .doc('dokter/$dokterUid/jadwal_konsultasi/$docId')
        .delete();
    return;
  }
}
