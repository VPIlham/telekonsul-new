import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekonsul/provider/diagnosis_provider.dart';
import 'package:telekonsul/provider/transaksi_provider.dart';
import 'page/pages.dart';
import 'provider/jadwal_konsultasi_provider.dart';
import 'provider/pasien_provider.dart';
import 'provider/antrian_provider.dart';
import 'provider/dokter_provider.dart';
import 'provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sebelum menggunakan service firebase, Firebase perlu diinisialisasi terlebih dahulu
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Wrap widget paling atas dengan MultiProvider
    // Agar bisa menggunakan berbagai provider di bawah widget treenya
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider untuk inisialisasi 1 provider
        ChangeNotifierProvider(
          create: (context) => DokterProvider(),
        ),
        // ChangeNotifierProxyProvider untuk menggunakan provider dengan class provider lain
        // Dengan mengupdate data Provider yang diinginkan ke dalam class provider yang membutuhkan
        ChangeNotifierProxyProvider<DokterProvider, UserProvider>(
          create: (context) => UserProvider(),
          update: (context, value, previous) => previous..update = value,
        ),
        ChangeNotifierProvider(
          create: (context) => JadwalKonsultasiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AntrianProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PasienProvider(),
        ),
        ChangeNotifierProxyProvider<PasienProvider, TransaksiProvider>(
          create: (context) => TransaksiProvider(),
          update: (context, value, previous) =>
              previous..updatePasienProvider = value,
        ),
        ChangeNotifierProvider(
          create: (context) => DiagnosisProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
        },
        theme: ThemeData(
            backgroundColor: Colors.white, primaryColor: Colors.white),
        builder: (context, child) {
          // Consumer untuk menggunakan class provider
          // Disini menggunakan UserProvider untuk mengecek
          // Apakah user pernah login, untuk diredirect ke halaman tertentu
          return Consumer<UserProvider>(
            child: child,
            builder: (context, value, child) {
              if (value.isLoading) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // Jika user pernah login akan diredirect langsung ke halaman User
              // Disini perlu diwrap dengan MaterialApp, karena builder ini akan
              // mengembalikan Widget dan menggantikan MaterialAppnya
              // Jika tidak diwrap dengan material app, maka halamanya tidak bisa berpindah
              // karena tidak ada navigator, MaterialApp sudah 1 paket dengan navigator
              // Bisa juga diwrap dengan widget Navigator, tetapi tidak akan efektif
              if (value.user != null) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      backgroundColor: Colors.white,
                      primaryColor: Colors.white),
                  home: BottomNavigationBarUserScreen(),
                );
              }

              // Di UserProvider memerlukan DokterProvider untuk mengecek apakah user
              // Login sebagai user atau dokter, jika sebagai dokter maka akan diredirect
              // Ke halaman dokter
              if (value.dokterProvider.dokter != null) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      backgroundColor: Colors.white,
                      primaryColor: Colors.white),
                  home: BottomNavigationBarDokterScreen(),
                );
              }

              // child ini adalah route paling awal yang sudah diinisial
              // yaitu SplashPage dengan initial '/'
              // Oleh karena itu jika user belum login sama sekali
              // Maka akan return SplashPage()
              return child;
            },
          );
        },
      ),
    );
  }
}
