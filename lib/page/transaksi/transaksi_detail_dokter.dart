part of '../pages.dart';

class TransaksiDetailDokter extends StatefulWidget {
  final Transaksi transaksi;

  const TransaksiDetailDokter({Key key, @required this.transaksi})
      : super(key: key);
  @override
  _TransaksiDetailDokterState createState() => _TransaksiDetailDokterState();
}

class _TransaksiDetailDokterState extends State<TransaksiDetailDokter> {
  Transaksi get transaksi => widget.transaksi;

  bool _isLoading = false;

  List<String> _status = ['Sukses', 'Gagal'];
  String _selectedStatus = 'Sukses';

  List<DropdownMenuItem> generateItems(List<String> statuses) {
    List<DropdownMenuItem> items = [];
    for (var status in statuses) {
      items.add(
        DropdownMenuItem(
          child: Text("$status"),
          value: status,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kembali")),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Transaksi ID #${transaksi.docId}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${DateFormat("dd MMMM yyyy").format(transaksi.createdAt)}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DETAIL TRANSAKSI",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      buildText("Nama Dokter", transaksi.dokterProfile.nama),
                      SizedBox(
                        height: 5,
                      ),
                      buildText("Waktu Konsultasi",
                          "${transaksi.jadwalKonsultasi.jamMulai.format(context)} - ${transaksi.jadwalKonsultasi.jamAkhir.format(context)}"),
                      SizedBox(
                        height: 5,
                      ),
                      buildText(
                          "No. Handphone", transaksi.dokterProfile.noTelp),
                      SizedBox(
                        height: 5,
                      ),
                      buildText("Pembayaran", "Bank BCA"),
                      SizedBox(
                        height: 5,
                      ),
                      buildText("No. Rekening", transaksi.dokterProfile.noRek),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text("Total"),
                          ),
                          Expanded(
                            child: Text(
                              "Rp. ${NumberFormat("#,###").format(transaksi.jadwalKonsultasi.harga)},-",
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text("Status"),
                          ),
                          Expanded(
                            child: StatusText(text: transaksi.status),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Pilih Status",
                      ),
                      const SizedBox(height: 4),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: _selectedStatus,
                            items: generateItems(_status),
                            onChanged: (item) {
                              setState(() {
                                _selectedStatus = item;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: MediaQuery.of(context).size.width * 0.56,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: transaksi.buktiPembayaran != ""
                                  ? NetworkImage(transaksi.buktiPembayaran)
                                  : AssetImage('assets/images.png'),
                              fit: BoxFit.contain,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                offset: Offset(4, 8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Center(
                        child: Text("* Foto bukti pembayaran",
                            style: Theme.of(context).textTheme.caption),
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Column(
                                children: [
                                  MaterialButton(
                                    minWidth: 148,
                                    height: 39,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    color: Color(0xff1AAEDD),
                                    child: Text(
                                      "Update Pembayaran",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      await Provider.of<TransaksiProvider>(
                                              context,
                                              listen: false)
                                          .updateStatus(
                                        transaksi.docId,
                                        transaksi.createdBy.uid,
                                        _selectedStatus,
                                        transaksi.dokterProfile.uid,
                                      );

                                      await Provider.of<TransaksiProvider>(
                                              context,
                                              listen: false)
                                          .getAllTransaksi(true,
                                              transaksi.dokterProfile.uid);

                                      setState(() {
                                        _isLoading = false;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Update pembayaran berhasil",
                                          ),
                                        ),
                                      );

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  MaterialButton(
                                    minWidth: 148,
                                    height: 39,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    color: Color(0xff1AAEDD),
                                    child: Text(
                                      "Download Invoice",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await _downloadData(context, transaksi);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _downloadData(BuildContext ctx, Transaksi data) async {
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
            child: pw.Text('Invoice #${data.docId}',
                style: pw.Theme.of(context).header3),
          );
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Table.fromTextArray(
              context: context,
              border: pw.TableBorder.all(),
              headers: <String>[
                'No',
                'Nama',
                'Jam Konsultasi',
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
                <String>[
                  '1',
                  'Konsultasi ${data.dokterProfile.nama} Spesialis ${data.dokterProfile.spesialis}',
                  '${data.jadwalKonsultasi.jamMulai.format(ctx)} - ${data.jadwalKonsultasi.jamAkhir.format(ctx)}',
                  '${NumberFormat("#,###").format(data.jadwalKonsultasi.harga)}'
                ],
              ]),
          pw.Paragraph(text: ""),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text("Status Pembayaran : ${data.status}"),
              ),
              pw.Expanded(
                child: pw.Column(children: [
                  pw.Text(
                    "Total : Rp. ${NumberFormat("#,###").format(data.jadwalKonsultasi.harga)},-",
                  ),
                  pw.Text("Payment Method: BCA"),
                ]),
              ),
            ],
          ),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ],
      ),
    );

    Directory appDocDir = await getApplicationDocumentsDirectory();
String appDocPath = appDocDir.path;
    final file = File("$appDocPath/invoice_${data.docId}.pdf");
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

  buildText(String title, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text("$title"),
        ),
        Expanded(
          child: Text(
            "$text",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
