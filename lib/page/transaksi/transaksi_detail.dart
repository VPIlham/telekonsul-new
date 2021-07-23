part of '../pages.dart';

class TransaksiDetail extends StatefulWidget {
  final Transaksi transaksi;

  const TransaksiDetail({Key key, @required this.transaksi}) : super(key: key);
  @override
  _TransaksiDetailState createState() => _TransaksiDetailState();
}

class _TransaksiDetailState extends State<TransaksiDetail> {
  Transaksi get transaksi => widget.transaksi;

  File imageFile;

  bool _isLoading = false;

  bool _isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kembali")),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 13),
                child: Center(
                  child: Container(
                    width: 241,
                    height: 37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffF1F1F1),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TRANSAKSI ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "BERHASIL ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff32BB1C)),
                        ),
                        Text(
                          "DIBUAT",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ),
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
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: transaksi.status == "Menunggu Pembayaran"
                            ? () async => await _pickImage()
                            : null,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: MediaQuery.of(context).size.width * 0.56,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: transaksi.buktiPembayaran != ""
                                  ? NetworkImage(transaksi.buktiPembayaran)
                                  : imageFile == null
                                      ? AssetImage('assets/images.png')
                                      : FileImage(imageFile),
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
                      Text("* Upload foto bukti pembayaran",
                          style: Theme.of(context).textTheme.caption),
                      const SizedBox(height: 16.0),
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(),
                      transaksi.status == "Menunggu Pembayaran" && !_isDone
                          ? Center(
                              child: MaterialButton(
                                minWidth: 148,
                                height: 39,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                color: Color(0xff1AAEDD),
                                child: Text(
                                  "KONFIRMASI PEMBAYARAN",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  bool konfirmasi = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                          "Anda yakin ingin menyelesaikan pembayaran ini?"),
                                      content: Text(
                                          "Anda akan menyelesaikan pembayaran ini dengan mengupload bukti pembayaran yang sudah berhasil"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text("Ya"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text("Tidak"),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (konfirmasi) {
                                    await _konfirmasiPembayaran();
                                  }

                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 76,
                        width: 339,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xffE0E0E0),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Mohon tunggu hingga pihak Dokter menghubungi\nAnda melalui WhatsApp. Pastikan WhatsApp Anda\nselalu aktif!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        minWidth: 148,
                        height: 39,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Color(0xff1AAEDD),
                        child: Text(
                          "Download Invoice",
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
                pw.Text('Invoice #${data.docId}',
                    style: pw.Theme.of(context).header3),
              ],
            ),
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

  _konfirmasiPembayaran() async {
    await _updateBuktiPembayaran();
    await Provider.of<TransaksiProvider>(context, listen: false)
        .getAllTransaksi(false, transaksi.createdBy.uid);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Konfirmasi Pembayaran Selesai"),
      ),
    );
  }

  _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      await _cropImage();
    }
    return;
  }

  _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        imageFile = croppedFile;
      });
    }
  }

  _updateBuktiPembayaran() async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pilih gambar untuk diupload"),
        ),
      );
      return;
    }

    try {
      final dataAuth = FirebaseAuth.instance;
      String fileName = imageFile.path.split("/").last;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Bukti Pembayaran/${dataAuth.currentUser.uid}/$fileName');

      final dataImage = await ref.putFile(imageFile);
      String photoPath = await dataImage.ref.getDownloadURL();

      await Provider.of<TransaksiProvider>(context, listen: false)
          .konfirmasiPembayaran(
        transaksi.docId,
        transaksi.dokterProfile.uid,
        photoPath,
        transaksi.createdBy.uid,
      );

      setState(() {
        _isDone = true;
      });

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
