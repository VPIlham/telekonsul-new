part of '../pages.dart';

class ListJadwalKonsultasi extends StatefulWidget {
  const ListJadwalKonsultasi({Key key}) : super(key: key);

  @override
  _ListJadwalKonsultasiState createState() => _ListJadwalKonsultasiState();
}

class _ListJadwalKonsultasiState extends State<ListJadwalKonsultasi> {
  bool _isLoading = false;

  @override
  void initState() {
    Provider.of<JadwalKonsultasiProvider>(context, listen: false)
        .getListJadwalKonsultasi(
            Provider.of<DokterProvider>(context, listen: false).dokter.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kembali"),
      ),
      body: Consumer<JadwalKonsultasiProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.listJadwalKonsultasi.isEmpty) {
            return Center(
              child: Text("Jadwal konsultasi anda masih kosong"),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List Jadwal Konsultasi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            await _downloadData(
                                context, value.listJadwalKonsultasi);

                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: Text("Download List"),
                        ),
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: value.listJadwalKonsultasi.length,
                  itemBuilder: (context, index) {
                    final item = value.listJadwalKonsultasi[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailJadwalKonsultasi(
                                  jadwal: item,
                                ),
                              ),
                            );
                          },
                          leading: Icon(Icons.schedule, color: Colors.blue),
                          title: Text("${item.hari.day}"),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hari: ${item.jamMulai.format(context)} - ${item.jamAkhir.format(context)}",
                              ),
                              Text(
                                "Harga: Rp. ${NumberFormat("#,###").format(item.harga)}",
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.navigate_next),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  _downloadData(BuildContext ctx, List<JadwalKonsultasi> data) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final pdf = pw.Document();

    final image = pw.MemoryImage(
      (await rootBundle.load('assets/medlinx.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Image(
                    image,
                    height: 36,
                    width: 180,
                    fit: pw.BoxFit.cover,
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text("Alamat : JL Fatmawati No 7, Jakarta Selatan"),
                  pw.Text("Tgl Transaksi ${DateTime.now().toString()}"),
                  pw.SizedBox(
                    height: 25,
                  ),
                  pw.Text('Laporan Jadwal Konsultasi',
                      style: pw.Theme.of(context).header3),
                ]),
          );
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Table.fromTextArray(
              context: context,
              border: pw.TableBorder.all(),
              headers: <String>[
                'No',
                'Hari',
                'Jam',
                'Harga',
              ],
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#FFF'),
              ),
              headerDecoration: pw.BoxDecoration(
                color: PdfColor.fromInt(0xffC62644),
              ),
              headerAlignment: pw.Alignment.centerLeft,
              data: <List<String>>[
                for (int i = 0; i < data.length; i++)
                  <String>[
                    '${i + 1}',
                    '${data[i].hari.day}',
                    '${data[i].jamMulai.format(ctx)} - ${data[i].jamAkhir.format(ctx)}',
                    'Rp. ${NumberFormat("#,###").format(data[i].harga)}',
                  ],
              ]),
          pw.Paragraph(text: ""),
          pw.Paragraph(
              text: "Total Jadwal Konsultasi : ${data.length}",
              textAlign: pw.TextAlign.right),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ],
      ),
    );

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final file = File(
        "$appDocPath/laporan_jadwal_konsultasi_${DateTime.now().toString()}.pdf");
    await file.writeAsBytes(await pdf.save()).whenComplete(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Tersimpan di ${file.path}"),
              duration: Duration(seconds: 5),
              action: SnackBarAction(
                label: "Open",
                onPressed: () async => await OpenFile.open(file.path),
              ),
            ),
          ),
        );
  }
}
