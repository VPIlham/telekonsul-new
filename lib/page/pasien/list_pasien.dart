part of '../pages.dart';

class ListPasien extends StatefulWidget {
  @override
  _ListPasienState createState() => _ListPasienState();
}

class _ListPasienState extends State<ListPasien> {
  bool _isLoading = false;

  @override
  void initState() {
    Provider.of<PasienProvider>(context, listen: false).getAllPasien(
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
      body: Consumer<PasienProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.listAllPasien.isEmpty) {
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
                      "List Pasien",
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

                              await _downloadData(value.listAllPasien);

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
                    itemCount: value.listAllPasien.length,
                    itemBuilder: (context, index) {
                      final item = value.listAllPasien[index];

                      return _pasienCard(item);
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

  _downloadData(List<UserModel> data) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final pdf = pw.Document();

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
            child: pw.Text('Laporan User', style: pw.Theme.of(context).header3),
          );
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Table.fromTextArray(
              context: context,
              border: pw.TableBorder.all(),
              headers: <String>[
                'No',
                'Nama',
                'Email',
                'Alamat',
                'No Telp',
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
                    '${data[i].nama}',
                    '${data[i].email}',
                    '${data[i].alamat}',
                    '${data[i].noTelp}',
                  ],
              ]),
          pw.Paragraph(text: ""),
          pw.Paragraph(
              text: "Total Pasien : ${data.length}",
              textAlign: pw.TextAlign.right),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ],
      ),
    );

    final path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    final file = File("$path/laporan_pasien_${DateTime.now().toString()}.pdf");
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

  _pasienCard(UserModel item) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey,
              backgroundImage:
                  item.profileUrl != "" ? NetworkImage(item.profileUrl) : null,
              child: item.profileUrl != ""
                  ? null
                  : Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
            ),
            title: Text("${item.nama}"),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Alamat: ${item.alamat}"),
              Text("No. Telepon: ${item.noTelp}"),
            ]),
          ),
        ),
      ),
    );
  }
}
