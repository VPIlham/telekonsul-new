import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:telekonsul/models/user/user.dart';

class PasienProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<UserModel> _pasien = [];
  List<UserModel> get pasien => _pasien;

  List<UserModel> _listAllPasien = [];
  List<UserModel> get listAllPasien => _listAllPasien;

  // Menambahkan data pasien ke subCollection dokter, perlu dicek terlebih dahulu apakah pasien tersebut sudha ada atau blom
  // Dengan mengecek documentId data pasien tersebut, karena ketika membuat document pasien menggunakan documentId yang sama dengan user oleh karena itu dapat dicek dengan lebih mudah
  addPasien(String uid, Map<String, dynamic> data) async {
    final dataPasien = await FirebaseFirestore.instance
        .doc('dokter/$uid/pasien/${data['doc_id']}')
        .get();

    if (dataPasien.exists) {
      return;
    }

    await FirebaseFirestore.instance
        .doc('dokter/$uid/pasien/${data['doc_id']}')
        .set(data);
  }

  // Mengambil data 7 pasien dari subCollection dokter, dengan limit 7, kemudian ditambahkan ke variabel _pasein
  get7Pasien(String uid) async {
    _isLoading = true;
    _pasien.clear();
    FirebaseFirestore.instance
        .doc('dokter/$uid')
        .collection('pasien')
        .limit(7)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      _pasien.addAll(value.docs.map((e) => UserModel.fromJson(e.data())));
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  // Mengambil seluru data dari subCollection dokter, yang ditambahkan ke variabel _listAllPasien
  getAllPasien(String uid) async {
    _isLoading = true;
    _listAllPasien.clear();
    FirebaseFirestore.instance
        .doc('dokter/$uid')
        .collection('pasien')
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      _listAllPasien
          .addAll(value.docs.map((e) => UserModel.fromJson(e.data())));
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
