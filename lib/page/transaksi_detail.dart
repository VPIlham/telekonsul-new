part of 'pages.dart';

class TransaksiDetail extends StatefulWidget {
  @override
  _TransaksiDetailState createState() => _TransaksiDetailState();
}

class _TransaksiDetailState extends State<TransaksiDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 11, left: 12),
                child: Text("< Kembali"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 13),
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
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 13, right: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transaksi ID #012312312",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "20 April 2021",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 35.w,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xffF1F1F1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          "DETAIL TRANSAKSI",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nama Dokter"),
                        Text(
                          "dr Johnson.SP.B",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Waktu Konsultasi"),
                        Text(
                          "12.00-12.30",
                          style: TextStyle(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("No. Handphone"),
                        Text(
                          "08977166220",
                          style: TextStyle(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pembayaran"),
                        Text(
                          "Bank BCA",
                          style: TextStyle(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("No. Rekening"),
                        Text(
                          "1231231221",
                          style: TextStyle(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text(
                          "RP. 50.000,-",
                          style: TextStyle(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status"),
                        Text(
                          "MENUNGGU PEMBAYARAN",
                          style: TextStyle(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 148,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff1AAEDD),
                        ),
                        child: Center(
                          child: Text(
                            "KONFIRMASI PEMBAYARAN",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
