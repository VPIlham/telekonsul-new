import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:telekonsul/models/dokter/dokter.dart';
import 'package:telekonsul/models/user/user.dart';

import 'dokter_provider.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel _user;
  UserModel get user => _user;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  DokterProvider _dokterProvider;
  DokterProvider get dokterProvider => _dokterProvider;

  // Update value DokterProvider yang sudah diinisial di ChangeNotifierProxyProvider
  set update(DokterProvider value) {
    this._dokterProvider = value;
    notifyListeners();
  }

  // Method dimasukkan ke dalam constructor, agara ketika class dipanggil methodnya juga dipanggil langsung
  // Disini memanggil getUser agar tau, ketika memanggil provider ini usernya berubah atau tidak (login atau belum)
  UserProvider() {
    getUser(this.dokterProvider);
  }

  // Mengambil data user berdaraskan perubahan FirebaseAuth
  // Dengan parameter DokterPovider untuk set data dokter jika yang login adalah dokter
  getUser(DokterProvider dokterProvider) async {
    _isLoading = true;
    _user = null;
    if (this.dokterProvider != null) this.dokterProvider.setDokter = null;
    FirebaseAuth.instance.userChanges().listen((currentUser) async {
      if (currentUser == null) {
        _user = null;
        if (this.dokterProvider != null) this.dokterProvider.setDokter = null;
        _isLoading = false;
        notifyListeners();
        return;
      }

      var dataUser = await FirebaseFirestore.instance
          .doc('users/${currentUser.uid}')
          .get();

      var dataDokter = await FirebaseFirestore.instance
          .doc('dokter/${currentUser.uid}')
          .get();

      if (dataUser.exists) {
        _user = UserModel.fromJson(dataUser.data());
        _isLoading = false;
        notifyListeners();
        return;
      } else if (dataDokter.exists) {
        if (this.dokterProvider != null)
          this.dokterProvider.setDokter = Dokter.fromJson(dataDokter.data());

        _isLoading = false;
        notifyListeners();
        return;
      }
    });
  }

  // Mengambil semua data di collection users, kemudian datanya ditambahkan ke List<UserModel> _users
  getAllUsers() async {
    _isLoading = true;
    _users.clear();
    FirebaseFirestore.instance.collection('users').get().then((value) {
      if (value.docs.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      _users.addAll(value.docs.map((e) => UserModel.fromJson(e.data())));
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
