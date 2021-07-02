import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telekonsul/models/diagnosis/diagnosis.dart';

class DiagnosisProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Diagnosis> _listDiagnosis = [];
  List<Diagnosis> get listDiagnosis => _listDiagnosis;

  // Mengambil semua data diagnosis dari subCollection user, kemudian dimasukkan ke _listDiagnosis
  getAllDiagnosis(String userUid) async {
    _isLoading = true;
    _listDiagnosis.clear();

    try {
      await FirebaseFirestore.instance
          .doc('users/$userUid')
          .collection('diagnosis')
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }

        _listDiagnosis
            .addAll(value.docs.map((e) => Diagnosis.fromJson(e.data())));
        _isLoading = false;
        notifyListeners();
        return;
      });
    } catch (e) {
      print("Something went wrong:" + e.toString());
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  // Menambahkan data diagnosis yang sudah dimasukan dokter ke subCollection user
  addDiagnosis(Map<String, dynamic> data, String userUid) async {
    _isLoading = true;

    try {
      await FirebaseFirestore.instance
          .doc('users/$userUid')
          .collection('diagnosis')
          .add(data)
          .then((value) async {
        await value.update({
          "doc_id": value.id,
        });
      });
    } catch (e) {
      print("Something went wrong:" + e.toString());
    }

    _isLoading = false;
    notifyListeners();
    return;
  }
}
