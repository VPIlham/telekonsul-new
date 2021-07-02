part of 'pages.dart';

class ListTransaksiDokter extends StatefulWidget {
  @override
  _ListTransaksiDokterState createState() => _ListTransaksiDokterState();
}

class _ListTransaksiDokterState extends State<ListTransaksiDokter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(left: 24, right: 24, top: 24),
          children: [
            Container(
              child: Text("< Kembali"),
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "LIST TRANSAKSI",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Container(
                  width: 111,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color(0xff619BF2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Download",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 68,
              decoration: BoxDecoration(
                  color: Color(0xffF3F3F3),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SUKSES : 1"),
                      Text("GAGAL  : 1"),
                      Text("PENDING  : 1")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "TOTAL PENDAPATAN",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "RP. 50.000,-",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 91,
                  width: 307,
                  child: Card(
                    color: Color(0xffFBFBFB),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TRANSAKSI ID #1123123122",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "20 APRIL 2021",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
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
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "BCA",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TOTAL : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Rp. 50.000,-",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "STATUS : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "MENUNGGU PEMBAYARAN",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4BC5FA),
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 91,
                  width: 307,
                  child: Card(
                    color: Color(0xffFBFBFB),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TRANSAKSI ID #1123123122",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "20 APRIL 2021",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
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
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "BCA",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TOTAL : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Rp. 50.000,-",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "STATUS : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "SUKSES",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0XFF56F53C),
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 91,
                  width: 307,
                  child: Card(
                    color: Color(0xffFBFBFB),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TRANSAKSI ID #1123123122",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "20 APRIL 2021",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
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
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "BCA",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TOTAL : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Rp. 50.000,-",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "STATUS : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "GAGAL",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0XFFFA3C3C),
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
