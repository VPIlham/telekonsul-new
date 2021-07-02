part of '../pages.dart';

class DetailKonsultasi extends StatefulWidget {
  final DataDokter dataDokter;
  const DetailKonsultasi({Key key, @required this.dataDokter})
      : super(key: key);

  @override
  _DetailKonsultasiState createState() => _DetailKonsultasiState();
}

class _DetailKonsultasiState extends State<DetailKonsultasi> {
  DataDokter get dataDokter => widget.dataDokter;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1,
                child: Stack(
                  children: [
                    Container(child: Image.asset('assets/medical.png')),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.grey,
                        backgroundImage: dataDokter.dokter.profileUrl != ""
                            ? NetworkImage(dataDokter.dokter.profileUrl)
                            : null,
                        child: dataDokter.dokter.profileUrl != ""
                            ? null
                            : Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 86,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    Text("${dataDokter.dokter.nama}",
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 8.0),
                    Text("${dataDokter.dokter.spesialis}",
                        style: Theme.of(context).textTheme.overline),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tersedia :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Container(
                          child: dataDokter.jadwalKonsultasi
                              .where((element) =>
                                  element.hari.intValue ==
                                  DateTime.now().weekday)
                              .map(
                                (e) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${e.jamMulai.format(context)} - ${e.jamAkhir.format(context)}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                              .first,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "Lokasi Praktik :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ListTile(
                      leading: Image.asset('assets/hospital.png'),
                      title: Text("${dataDokter.dokter.alamat}"),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text(
                          "Bank :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Text(
                              "BCA",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 22),
                        Text(
                          "Total :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        dataDokter.jadwalKonsultasi
                            .where((element) =>
                                element.hari.intValue == DateTime.now().weekday)
                            .map(
                              (e) => Text(
                                "Rp. ${NumberFormat("#,###").format(e.harga)},-",
                              ),
                            )
                            .first,
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Center(
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : MaterialButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                final dataTransaksi = await _pesanSekarang();
                                setState(() {
                                  _isLoading = false;
                                });
                                if (dataTransaksi != null) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => TransaksiDetail(
                                        transaksi: dataTransaksi,
                                      ),
                                    ),
                                  );
                                }
                              },
                              color: Colors.lightBlue,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              child: Text("Pesan Sekarang"),
                              minWidth: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Transaksi> _pesanSekarang() async {
    UserModel dataPasien =
        Provider.of<UserProvider>(context, listen: false).user;

    JadwalKonsultasi jadwal = dataDokter.jadwalKonsultasi
        .where((element) => element.hari.intValue == DateTime.now().weekday)
        .first;

    DateTime now = DateTime.now();
    DateTime jamMulai = DateTime(now.year, now.month, now.day,
        jadwal.jamMulai.hour, jadwal.jamMulai.minute);
    DateTime jamAkhir = DateTime(now.year, now.month, now.day,
        jadwal.jamAkhir.hour, jadwal.jamAkhir.minute);

    Map<String, dynamic> dataJadwal = {
      'hari': jadwal.hari.toJson(),
      'jam_mulai': DateFormat("hh:mm a").format(jamMulai),
      'jam_akhir': DateFormat("hh:mm a").format(jamAkhir),
      'harga': jadwal.harga,
    };

    Map<String, dynamic> dataTransaksi = {
      'dokter_profile': dataDokter.dokter.toJson(),
      'jadwal_konsultasi': dataJadwal,
      'status': "Menunggu Pembayaran",
      'bukti_pembayaran': "",
      'created_at': Timestamp.now(),
      'created_by': dataPasien.toJson(),
    };

    final transaksi =
        await Provider.of<TransaksiProvider>(context, listen: false)
            .addTransaksi(
      dokterId: dataDokter.dokter.uid,
      dataTransaksi: dataTransaksi,
      dataPasien: dataPasien.toJson(),
      userUid: dataPasien.uid,
    );

    if (transaksi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan"),
        ),
      );
      return null;
    }

    final docAntrian = await FirebaseFirestore.instance
        .doc('dokter/${dataDokter.dokter.uid}')
        .collection('antrian')
        .where('is_done', isEqualTo: false)
        .get();

    List<Antrian> listAntrian = [];
    listAntrian.addAll(docAntrian.docs.map((e) => Antrian.fromJson(e.data())));

    DateTime before = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    DateTime after = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

    listAntrian = listAntrian
        .where(
          (element) =>
              element.createdAt.isBefore(before) &&
              element.createdAt.isAfter(after),
        )
        .toList();

    int nomorAntrian = 1;

    if (listAntrian.length > 0) {
      nomorAntrian = listAntrian.length + 1;
    }

    Map<String, dynamic> newDataTransaksi = {
      'doc_id': transaksi.docId,
      'dokter_profile': transaksi.dokterProfile.toJson(),
      'jadwal_konsultasi': dataJadwal,
      'status': transaksi.status,
      'bukti_pembayaran': transaksi.buktiPembayaran,
      'created_at': Timestamp.now(),
      'created_by': transaksi.createdBy.toJson(),
    };

    Map<String, dynamic> dataAntrian = {
      'doc_id': transaksi.docId,
      'data_transaksi': newDataTransaksi,
      'nomor_antrian': nomorAntrian,
      'is_done': false,
      'created_at': Timestamp.now(),
    };

    await Provider.of<AntrianProvider>(context, listen: false)
        .addAntrian(dataDokter.dokter.uid, dataAntrian);

    await Provider.of<DokterProvider>(context, listen: false)
        .getAllDokter(transaksi.createdBy.uid);

    return transaksi;
  }
}
