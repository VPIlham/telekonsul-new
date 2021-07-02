import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telekonsul/models/antrian/antrian.dart';
import 'package:telekonsul/models/dokter/dokter.dart';
import 'package:telekonsul/models/jadwal_konsultasi/jadwal_konsultasi.dart';

class DokterProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Dokter _dokter;
  Dokter get dokter => _dokter;
  set setDokter(Dokter dokter) {
    this._dokter = dokter;
    notifyListeners();
  }

  Dokter _currentDokter;
  Dokter get currentDokter {
    if (_currentDokter == null) {
      getCurrentDokter();
    }

    return _currentDokter;
  }

  List<DataDokter> _listDokter = [];
  List<DataDokter> get listDokter => _listDokter;

  List<DataDokter> _listSpesialisDokter = [];
  List<DataDokter> get listSpesialisDokter => _listSpesialisDokter;

  // Mengabil data currentDokter yang login, dengan memngabil data uid dari FirebasAuth
  getCurrentDokter() async {
    _isLoading = true;
    _currentDokter = null;
    String uid = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.doc('dokter/$uid').get().then((value) {
      if (value.exists) {
        _currentDokter = Dokter.fromJson(value.data());
      }
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  // Mengambil semua data dokter, kemudian dimasukan ke _listDokter yang mempunyai data Dokter, Jadwal Konsultasi dan isBooked
  // Jika data dokter kosong maka akan direturn, jika tidak maka data dokter tersebut akan dimasukan ke _listDokter, kemudian menginisialisasi JadwalKonsultasi dengan [] karena List, dan isBooked false, karena belum tau apakah sudah di book atau belum
  // Kemudian mengabil data jadwal konsultasi dari masing" dokter yang ada di collection dokter, jika kosong maka direturn dengan jadwalKonsultasi [] (datanya kosong), dan isBooked false
  // Jika tidak kosong maka akan dimasukkan ke jadwal konsultasi data dokter tersebut
  // Kemudian dicek apakah sudah di book oleh user dengan method yang sudah dibuat di class ini juga
  // Yang terkahir kita pilih dokternya sesuai jadwal konsultasi hari ini, dimulai dengan Senin (1) - Minggu (7)
  // Karena hanya diperlukan 7 data, maka jika datnya lebih dari 7 maka akan dihapus dengan removeRange dari 8 sampek akhir list
  getAllDokter(String userUid) async {
    _isLoading = true;
    _listDokter.clear();

    final dataDokter =
        await FirebaseFirestore.instance.collection('dokter').get();

    if (dataDokter.docs.isEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    _listDokter.addAll(
      dataDokter.docs.map(
        (e) => DataDokter()
          ..dokter = Dokter.fromJson(e.data())
          ..jadwalKonsultasi = []
          ..isBooked = false,
      ),
    );

    await Future.forEach<DataDokter>(_listDokter, (element) async {
      final dataJadwal = await FirebaseFirestore.instance
          .doc('dokter/${element.dokter.uid}')
          .collection('jadwal_konsultasi')
          .get();

      if (dataJadwal.docs.isEmpty) {
        element.jadwalKonsultasi.addAll([]);
        element.isBooked = false;
        return;
      }

      element.jadwalKonsultasi.addAll(
          dataJadwal.docs.map((e) => JadwalKonsultasi.fromJson(e.data())));

      element.isBooked = await this.checkIfBooked(element.dokter.uid, userUid);
    });

    _listDokter = _listDokter
        .where((element) => element.jadwalKonsultasi
            .any((element) => element.hari.intValue == DateTime.now().weekday))
        .toList();

    if (_listDokter.length > 7) {
      _listDokter.removeRange(8, _listDokter.length);
    }
    _isLoading = false;
    notifyListeners();
    return;
  }

  // Prosesnya sama seperti mengambil data semua dokter, yang membedakan kita menggambil data spesialis dokter dengan where
  getSpesialisDokter(String spesialis, String userUid) async {
    _isLoading = true;
    _listSpesialisDokter.clear();

    final dataDokter = await FirebaseFirestore.instance
        .collection('dokter')
        .where('spesialis', isEqualTo: spesialis)
        .get();

    if (dataDokter.docs.isEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    _listSpesialisDokter.addAll(
      dataDokter.docs.map(
        (e) => DataDokter()
          ..dokter = Dokter.fromJson(e.data())
          ..jadwalKonsultasi = []
          ..isBooked = false,
      ),
    );

    await Future.forEach<DataDokter>(_listSpesialisDokter, (element) async {
      final dataJadwal = await FirebaseFirestore.instance
          .doc('dokter/${element.dokter.uid}')
          .collection('jadwal_konsultasi')
          .get();

      if (dataJadwal.docs.isEmpty) {
        element.jadwalKonsultasi.addAll([]);
        element.isBooked = false;
        return;
      }

      element.jadwalKonsultasi.addAll(
          dataJadwal.docs.map((e) => JadwalKonsultasi.fromJson(e.data())));

      element.isBooked = await this.checkIfBooked(element.dokter.uid, userUid);
    });
    _listSpesialisDokter = _listSpesialisDokter
        .where((element) => element.jadwalKonsultasi
            .any((element) => element.hari.intValue == DateTime.now().weekday))
        .toList();
    _isLoading = false;
    notifyListeners();
    return;
  }

  // Mengupdate data dokter
  updateDokter(String uid, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.doc('dokter/$uid').update(data);
    notifyListeners();
    return;
  }

  // Mengecek apakah user sudah di book dengan mengambil data antrian dokter hari ini
  // Kemudian dicocokan apakah data tersebut pernah dibuat oleh user dan antrianya belum selesai
  // Jika sudah maka dokter sudah di book
  checkIfBooked(String dokterId, String userUid) async {
    bool isBooked = false;

    try {
      final dataAntrianDokter = await FirebaseFirestore.instance
          .doc('dokter/$dokterId')
          .collection('antrian')
          .where('is_done', isEqualTo: false)
          .get();

      if (dataAntrianDokter.docs.isEmpty) {
        return isBooked;
      }

      List<Antrian> dataAntrian = [];
      dataAntrian.addAll(
          dataAntrianDokter.docs.map((e) => Antrian.fromJson(e.data())));

      DateTime before = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
      DateTime after = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

      dataAntrian = dataAntrian
          .where(
            (element) =>
                element.createdAt.isBefore(before) &&
                element.createdAt.isAfter(after),
          )
          .toList();

      isBooked = dataAntrian
          .any((element) => element.dataTransaksi.createdBy.uid == userUid);
    } catch (e) {
      print("Something went wrong: " + e.toString());
    }

    return isBooked;
  }
}
