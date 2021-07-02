part of '../pages.dart';

class ListTransaksiDokter extends StatefulWidget {
  @override
  _ListTransaksiDokterState createState() => _ListTransaksiDokterState();
}

class _ListTransaksiDokterState extends State<ListTransaksiDokter> {
  bool _isLoading = false;

  int sukses = 0;
  int gagal = 0;
  int pending = 0;

  double pendapatan = 0.0;

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  List<Transaksi> _searchResult = [];
  List<Transaksi> listSukses = [];

  bool _isEmpty = false;

  @override
  void initState() {
    Provider.of<TransaksiProvider>(context, listen: false).getAllTransaksi(
        true, Provider.of<DokterProvider>(context, listen: false).dokter.uid);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TransaksiProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (value.listTransaksi.isEmpty) {
              return Center(
                child: Text("Anda belum pernah melakukan transaksi"),
              );
            }

            pendapatan = 0;

            sukses = value.listTransaksi
                .where((element) => element.status == 'Sukses')
                .length;
            gagal = value.listTransaksi
                .where((element) => element.status == 'Gagal')
                .length;
            pending = value.listTransaksi
                .where((element) =>
                    element.status == 'Menunggu Pembayaran' ||
                    element.status == 'Menunggu Konfirmasi')
                .length;

            listSukses = value.listTransaksi
                .where((element) => element.status == 'Sukses')
                .toList();

            listSukses
                .map((e) => pendapatan += e.jadwalKonsultasi.harga)
                .toSet();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "List Transaksi",
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
                                  value.listTransaksi,
                                  sukses,
                                  gagal,
                                  pending,
                                  pendapatan,
                                );

                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: Text("Download List"),
                            ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildRichText(
                                  status: "Sukses",
                                  textColor: Colors.greenAccent,
                                  total: sukses,
                                ),
                                const SizedBox(height: 4),
                                buildRichText(
                                  status: "Gagal",
                                  textColor: Colors.redAccent,
                                  total: gagal,
                                ),
                                const SizedBox(height: 4),
                                buildRichText(
                                  status: "Pending",
                                  textColor: Colors.blueAccent,
                                  total: pending,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Total Pendapatan"),
                                const SizedBox(height: 8),
                                Text(
                                  "Rp. ${NumberFormat("#,###").format(pendapatan)},-",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              _focusNode.unfocus();
                              _searchResult.clear();
                              _isEmpty = false;
                            });
                          }),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: "Cari Transaksi by Status",
                    ),
                    onChanged: (query) {
                      if (query.isEmpty || query == "") {
                        setState(() {
                          _searchResult.clear();
                          _isEmpty = false;
                        });
                        return;
                      }

                      _searchResult.clear();

                      value.listTransaksi.forEach((element) {
                        if (element.status.contains(query)) {
                          setState(() {
                            _searchResult.add(element);
                            _isEmpty = false;
                            return;
                          });
                        }
                      });

                      if (_searchResult.isEmpty) {
                        setState(() {
                          _isEmpty = true;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _isEmpty
                      ? Center(
                          child: Text("Hasil searching transaksi kosong"),
                        )
                      : Expanded(
                          child: _searchResult.isNotEmpty &&
                                  _controller.text.isNotEmpty
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    final item =
                                        _searchResult.toSet().toList()[index];

                                    return _transaksiCard(item);
                                  },
                                  itemCount: _searchResult.toSet().length,
                                  shrinkWrap: true,
                                )
                              : ListView.builder(
                                  itemCount: value.listTransaksi.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final item = value.listTransaksi[index];

                                    return _transaksiCard(item);
                                  },
                                ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _transaksiCard(Transaksi item) {
    return Card(
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TransaksiDetailDokter(transaksi: item),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Transaksi ID #${item.docId}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${DateFormat("dd MMMM yyyy").format(item.createdAt)}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BANK : ",
                    style: TextStyle(),
                  ),
                  Text(
                    "BCA",
                    style: TextStyle(),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL : ",
                    style: TextStyle(),
                  ),
                  Text(
                    "Rp. ${NumberFormat("#,###").format(item.jadwalKonsultasi.harga)},-",
                    style: TextStyle(),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STATUS : ",
                    style: TextStyle(),
                  ),
                  StatusText(text: item.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildRichText({String status, Color textColor, int total}) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "Transaksi ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextSpan(
          text: " $status ",
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        TextSpan(
          text: " : $total",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }

  _downloadData(
    List<Transaksi> data,
    int sukses,
    int gagal,
    int pending,
    double pendapatan,
  ) async {
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
            child: pw.Text('Laporan Transaksi',
                style: pw.Theme.of(context).header3),
          );
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Table.fromTextArray(
              context: context,
              border: pw.TableBorder.all(),
              headers: <String>[
                'No',
                'Transaksi ID',
                'Bank',
                'Sub Total',
                'Status',
                'Tgl Dibuat',
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
                    '${data[i].docId}',
                    'BCA',
                    '${data[i].jadwalKonsultasi.harga}',
                    '${data[i].status}',
                    '${DateFormat("dd MMMM yyyy").format(data[i].createdAt)}',
                  ],
              ]),
          pw.Paragraph(text: ""),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Total Transaksi : ${data.length}"),
                pw.Text(
                    "Total Pendapatan : Rp. ${NumberFormat("#,###").format(pendapatan)},-"),
              ]),
          pw.Paragraph(
            text: "Total Transaksi Sukses : $sukses",
            textAlign: pw.TextAlign.right,
          ),
          pw.Paragraph(
            text: "Total Transaksi Gagal: $gagal",
            textAlign: pw.TextAlign.right,
          ),
          pw.Paragraph(
            text: "Total Transaksi Pending : $pending",
            textAlign: pw.TextAlign.right,
          ),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ],
      ),
    );

    final path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    final file =
        File("$path/laporan_transaksi_${DateTime.now().toString()}.pdf");
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
