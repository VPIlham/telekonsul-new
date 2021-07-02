import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telekonsul/models/transaksi/transaksi.dart';
import 'package:telekonsul/provider/pasien_provider.dart';

class TransaksiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Transaksi> _listTransaksi = [];
  List<Transaksi> get listTransaksi => _listTransaksi;

  Transaksi _transaksi;
  Transaksi get transaksi => _transaksi;

  PasienProvider _pasienProvider;
  PasienProvider get pasienProvider => _pasienProvider;

  // Update value PasienProvider yang sudah diinisial di ChangeNotifierProxyProvider
  set updatePasienProvider(PasienProvider pasienProvider) {
    this._pasienProvider = pasienProvider;
    notifyListeners();
  }

  // Memgambil data subCollection transaksi, diperlukan parameter isDokter untuk mengetahui yang diambil data user atau dokter
  // dan juga uid atau docId agar bisa mengakses subCollection transaksi dari docId tersebut
  // Kemudian dimasukan ke variabel _listTransaksi
  getAllTransaksi(bool isDokter, String uid) async {
    String role = isDokter ? 'dokter' : 'users';
    _isLoading = true;
    _listTransaksi.clear();

    try {
      await FirebaseFirestore.instance
          .doc('$role/$uid')
          .collection('transaksi')
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }

        _listTransaksi
            .addAll(value.docs.map((e) => Transaksi.fromJson(e.data())));
        _isLoading = false;
        notifyListeners();
        return;
      });
    } catch (e) {
      print("Something went wrong :" + e.toString());
      _isLoading = false;
      notifyListeners();
      return;
    }
  }

  // Menambahkan transaksi ke subCollection untuk mengakses subCollection diperlukan uid disini masing" transaksi akan
  // dimasukkan ke subCollection transaksi dokter dan juga user, oleh karena itu diperlukan iD mereka dan tentu saja dataTransaksinya
  // Ada dataPasien juga untuk dimasukkan ke subCollection dokter, karena menggunakan PasienProvider maka tinggal dipanggil method untuk menambahkan pasiennya
  Future<Transaksi> addTransaksi({
    String dokterId,
    Map<String, dynamic> dataTransaksi,
    Map<String, dynamic> dataPasien,
    String userUid,
  }) async {
    _isLoading = true;
    this._transaksi = null;

    await FirebaseFirestore.instance
        .doc('dokter/$dokterId')
        .collection('transaksi')
        .add(dataTransaksi)
        .then((value) async {
      await value.update({
        'doc_id': value.id,
      });
      final data = await value.get();
      this._transaksi = Transaksi.fromJson(data.data());
      dataTransaksi['doc_id'] = value.id;
    });

    await FirebaseFirestore.instance
        .doc('users/$userUid/transaksi/${dataTransaksi['doc_id']}')
        .set(dataTransaksi);

    await this.pasienProvider.addPasien(dokterId, dataPasien);

    return this._transaksi;
  }

  // Mengkofirmasi data pembayaran user, dengan mengupload imgUrl yang sudah didapatkan dari firebase storage (bukti pembayaran disimpan disini)
  // Kemudian data status diganti menunggu konfirmasi dari dokter
  konfirmasiPembayaran(
      String docId, String dokterId, String imgUrl, String userUid) async {
    _isLoading = true;

    await FirebaseFirestore.instance
        .doc('users/$userUid/transaksi/$docId')
        .update({
      'bukti_pembayaran': imgUrl,
      'status': "Menunggu Konfirmasi",
    });

    await FirebaseFirestore.instance
        .doc('dokter/$dokterId/transaksi/$docId')
        .update({
      'bukti_pembayaran': imgUrl,
      'status': "Menunggu Konfirmasi",
    });

    await FirebaseFirestore.instance
        .doc('dokter/$dokterId/antrian/$docId')
        .update({
      'bukti_pembayaran': imgUrl,
      'status': "Menunggu Konfirmasi",
    });

    _isLoading = false;
    notifyListeners();
    return;
  }

  // Mengupdate status transaksi ke 3 collection yang menyimpan data transaksi yang sama dan juga docId yang sama
  updateStatus(
      String docId, String userId, String status, String dokterUid) async {
    _isLoading = true;

    await FirebaseFirestore.instance
        .doc('users/$userId/transaksi/$docId')
        .update({
      'status': status,
    });

    await FirebaseFirestore.instance
        .doc('dokter/$dokterUid/transaksi/$docId')
        .update({
      'status': status,
    });

    await FirebaseFirestore.instance
        .doc('dokter/$dokterUid/antrian/$docId')
        .update({
      'status': status,
    });

    _isLoading = false;
    notifyListeners();
    return;
  }
}
