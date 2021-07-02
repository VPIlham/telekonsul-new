import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telekonsul/models/antrian/antrian.dart';

class AntrianProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Antrian> _listAntrian = [];
  List<Antrian> get listAntrian => _listAntrian;

  List<Antrian> _listAllAntrian = [];
  List<Antrian> get listAllAntrian => _listAllAntrian;

  // Besok
  DateTime before = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  // Kemaren
  DateTime after = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  // Mengambil semua data antrian hari ini dengan limit 7 dari subCollection dokter
  // Kemudian dimasukkan ke variabel _listAntrian
  get7Antrian(String dokterId) async {
    _isLoading = true;
    _listAntrian.clear();

    try {
      await FirebaseFirestore.instance
          .doc('dokter/$dokterId')
          .collection('antrian')
          .where('is_done', isEqualTo: false)
          .orderBy('nomor_antrian', descending: false)
          .limit(7)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }

        _listAntrian.addAll(value.docs.map((e) => Antrian.fromJson(e.data())));

        _listAntrian = _listAntrian
            .where(
              (element) =>
                  element.createdAt.isBefore(before) &&
                  element.createdAt.isAfter(after),
            )
            .toList();

        _isLoading = false;
        notifyListeners();
        return;
      });
    } catch (e) {
      print("Something went wrong: " + e.toString());
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  // Mengambil semua data antrian hari ini dari subCollection dokter
  // Kemudian dimasukkan ke variabel _lisAllAntrian
  getAllAntrian(String dokterId) async {
    _isLoading = true;
    _listAllAntrian.clear();

    try {
      await FirebaseFirestore.instance
          .doc('dokter/$dokterId')
          .collection('antrian')
          .where('is_done', isEqualTo: false)
          .orderBy('nomor_antrian', descending: false)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }

        _listAllAntrian
            .addAll(value.docs.map((e) => Antrian.fromJson(e.data())));

        _listAllAntrian = _listAllAntrian
            .where(
              (element) =>
                  element.createdAt.isBefore(before) &&
                  element.createdAt.isAfter(after),
            )
            .toList();

        _isLoading = false;
        notifyListeners();
        return;
      });
    } catch (e) {
      print("Something went wrong: " + e.toString());
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  // Menambahkan data antrian ke subCollection dokter
  addAntrian(String dokterId, Map<String, dynamic> data) async {
    _isLoading = true;

    try {
      await FirebaseFirestore.instance
          .doc('dokter/$dokterId/antrian/${data['doc_id']}')
          .set(data);
    } catch (e) {
      print("Something went wrong: " + e.toString());
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  updateNomorAntrian({
    String dokterId,
    String antrianId,
    int nomor,
  }) async {
    _isLoading = true;

    try {
      await FirebaseFirestore.instance
          .doc('dokter/$dokterId/antrian/$antrianId')
          .update({
        'nomor_antrian': nomor,
      });
    } catch (e) {
      print("Something went wrong: " + e.toString());
      _isLoading = false;
      notifyListeners();
      return;
    }
  }
}
