part of '../pages.dart';

class ListAntrianDokter extends StatefulWidget {
  @override
  _ListAntrianDokterState createState() => _ListAntrianDokterState();
}

class _ListAntrianDokterState extends State<ListAntrianDokter> {
  bool _isLoading = false;

  @override
  void initState() {
    Provider.of<AntrianProvider>(context, listen: false).getAllAntrian(
      Provider.of<DokterProvider>(context, listen: false).dokter.uid,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kembali"),
      ),
      body: Consumer<AntrianProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.listAllAntrian.isEmpty) {
            return Center(
              child: Text("Data pasien masih kosong"),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List Antrian",
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

                              await _downloadData(value.listAllAntrian);

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
                    shrinkWrap: true,
                    itemCount: value.listAllAntrian.length,
                    itemBuilder: (context, index) {
                      final item = value.listAllAntrian[index];

                      return _antrianCard(item);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _downloadData(List<Antrian> data) async {
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
                  pw.Text("Tgl Antrian : ${DateTime.now().toString()}"),
                  pw.SizedBox(
                    height: 25,
                  ),
                  pw.Text('Laporan Antrian',
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
                'Nama',
                'No. Telp',
                'Nomor Antrian',
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
                    '${data[i].dataTransaksi.createdBy.nama}',
                    '${data[i].dataTransaksi.createdBy.noTelp}',
                    '${data[i].nomorAntrian}',
                  ],
              ]),
          pw.Paragraph(text: ""),
          pw.Paragraph(
              text: "Total Antrian : ${data.length}",
              textAlign: pw.TextAlign.right),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ],
      ),
    );

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final file =
        File("$appDocPath/laporan_antrian_${DateTime.now().toString()}.pdf");
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

  _antrianCard(Antrian item) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditAntrian(antrian: item),
            ));
          },
          leading: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey,
            backgroundImage: item.dataTransaksi.createdBy.profileUrl != ""
                ? NetworkImage(item.dataTransaksi.createdBy.profileUrl)
                : null,
            child: item.dataTransaksi.createdBy.profileUrl != ""
                ? null
                : Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1, child: Text("${item.dataTransaksi.createdBy.nama}")),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    "${item.dataTransaksi.jadwalKonsultasi.jamMulai.format(context)} - ${item.dataTransaksi.jadwalKonsultasi.jamAkhir.format(context)}",
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ),
            ],
          ),
          isThreeLine: true,
          subtitle: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Text("No. Telp : ${item.dataTransaksi.createdBy.noTelp}"),
                    const SizedBox(height: 4.0),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "${DateFormat("EEEE, dd MMMM yyyy").format(item.createdAt)}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => KonsultasiPage(
                              antrian: item,
                            ),
                          ),
                        );
                      },
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: Text("Mulai Konsultasi"),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "${item.nomorAntrian}",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
