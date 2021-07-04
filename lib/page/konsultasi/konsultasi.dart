part of '../pages.dart';

class KonsultasiPage extends StatefulWidget {
  final Antrian antrian;

  const KonsultasiPage({Key key, @required this.antrian}) : super(key: key);
  @override
  _KonsultasiPageState createState() => _KonsultasiPageState();
}

class _KonsultasiPageState extends State<KonsultasiPage> {
  Antrian get antrian => widget.antrian;

  bool _isLoading = false;

  Dokter currentDokter;

  TextEditingController _txtDiagnosis = TextEditingController();

  @override
  void initState() {
    currentDokter = Provider.of<DokterProvider>(context, listen: false).dokter;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kembali"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                            "Transaksi ID #${antrian.dataTransaksi.docId}"),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            "${DateFormat("dd MMMM yyyy").format(antrian.dataTransaksi.createdAt)}"),
                      ),
                    ]),
                const SizedBox(height: 8),
                Text(
                    "Rp. ${NumberFormat("#,###").format(antrian.dataTransaksi.jadwalKonsultasi.harga)},-"),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    "${antrian.dataTransaksi.jadwalKonsultasi.jamMulai.format(context)} - ${antrian.dataTransaksi.jadwalKonsultasi.jamAkhir.format(context)}",
                  ),
                ),
                const SizedBox(height: 56),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            antrian.dataTransaksi.createdBy.profileUrl != ""
                                ? NetworkImage(
                                    antrian.dataTransaksi.createdBy.profileUrl)
                                : null,
                        child: antrian.dataTransaksi.createdBy.profileUrl != ""
                            ? null
                            : Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 86,
                                ),
                              ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${antrian.dataTransaksi.createdBy.nama}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Ketika anda mengklik Mulai\nAnda sedang melakukan Konsultasi",
                      ),
                      const SizedBox(height: 16),
                      _isLoading
                          ? CircularProgressIndicator()
                          : currentDokter.isBusy || antrian.isDone
                              ? MaterialButton(
                                  minWidth: 148,
                                  height: 39,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Colors.red,
                                  child: Text(
                                    "Selesai",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _selesai(context);
                                    setState(() {
                                      _isLoading = false;
                                    });

                                    Navigator.of(context).pop();
                                  },
                                )
                              : MaterialButton(
                                  minWidth: 148,
                                  height: 39,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(0xff1AAEDD),
                                  child: Text(
                                    "Mulai",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _mulaiKonsultasi();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _mulaiKonsultasi() async {
    bool konfirmasi = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Anda yakin ingin memulai konsultasi?"),
        content: Text(
            "Anda akan diredirect ke WhatsApp untuk memulai konsultasi dengan pasien"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("Ya"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Tidak"),
          ),
        ],
      ),
    );

    if (konfirmasi) {
      String _url =
          "https://api.whatsapp.com/send?phone=${antrian.dataTransaksi.createdBy.noTelp}";

      await canLaunch(_url)
          ? await launch(_url)
          : throw 'Could not launch $_url';

      Dokter newData = currentDokter;
      newData.isBusy = true;
      Provider.of<DokterProvider>(context, listen: false).setDokter = newData;

      await FirebaseFirestore.instance
          .doc('dokter/${currentDokter.uid}')
          .update({
        'is_busy': true,
      });
    }
  }

  _selesai(BuildContext context) async {
    bool konfirmasi = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Anda yakin ingin menyelesaikan konsultasi ini?"),
        content: Text(
            "Setelah konsultasi selesai, anda akan dimintai diagnosis penyakit yang dialami pasien"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("Ya"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Tidak"),
          ),
        ],
      ),
    );

    if (konfirmasi) {
      Dokter newData = currentDokter;
      newData.isBusy = false;
      Provider.of<DokterProvider>(context, listen: false).setDokter = newData;

      await FirebaseFirestore.instance
          .doc('dokter/${currentDokter.uid}')
          .update({
        'is_busy': false,
      });

      await FirebaseFirestore.instance
          .doc('dokter/${currentDokter.uid}/antrian/${antrian.docId}')
          .update({
        'is_done': true,
      });

      String diagnosis = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Diagnosis Gejala Pasien"),
          content: TextField(
            controller: _txtDiagnosis,
            decoration: InputDecoration(hintText: "Diagnosis Pasien"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(_txtDiagnosis.text),
              child: Text("Selesai"),
            ),
          ],
        ),
      );

      DateTime now = DateTime.now();
      DateTime jamMulai = DateTime(
          now.year,
          now.month,
          now.day,
          antrian.dataTransaksi.jadwalKonsultasi.jamMulai.hour,
          antrian.dataTransaksi.jadwalKonsultasi.jamMulai.minute);
      DateTime jamAkhir = DateTime(
          now.year,
          now.month,
          now.day,
          antrian.dataTransaksi.jadwalKonsultasi.jamAkhir.hour,
          antrian.dataTransaksi.jadwalKonsultasi.jamAkhir.minute);

      Map<String, dynamic> dataJadwal = {
        'hari': antrian.dataTransaksi.jadwalKonsultasi.hari.toJson(),
        'jam_mulai': DateFormat("hh:mm a").format(jamMulai),
        'jam_akhir': DateFormat("hh:mm a").format(jamAkhir),
        'harga': antrian.dataTransaksi.jadwalKonsultasi.harga,
      };

      Map<String, dynamic> dataTransaksi = {
        'doc_id': antrian.dataTransaksi.docId,
        'dokter_profile': antrian.dataTransaksi.dokterProfile.toJson(),
        'jadwal_konsultasi': dataJadwal,
        'status': antrian.dataTransaksi.status,
        'bukti_pembayaran': antrian.dataTransaksi.buktiPembayaran,
        'created_at': Timestamp.fromDate(antrian.dataTransaksi.createdAt),
        'created_by': antrian.dataTransaksi.createdBy.toJson(),
      };

      Map<String, dynamic> dataAntrian = {
        'doc_id': antrian.docId,
        'data_transaksi': dataTransaksi,
        'nomor_antrian': antrian.nomorAntrian,
        'is_done': false,
        'created_at': Timestamp.fromDate(antrian.createdAt),
      };

      Map<String, dynamic> data = {
        'data_antrian': dataAntrian,
        'diagnosis': diagnosis ?? "",
        'created_at': Timestamp.now(),
      };

      await Provider.of<DiagnosisProvider>(context, listen: false)
          .addDiagnosis(data, antrian.dataTransaksi.createdBy.uid);

      await Provider.of<AntrianProvider>(context, listen: false)
          .get7Antrian(antrian.dataTransaksi.dokterProfile.uid);

      await Provider.of<AntrianProvider>(context, listen: false)
          .getAllAntrian(antrian.dataTransaksi.dokterProfile.uid);
    }
  }
}
