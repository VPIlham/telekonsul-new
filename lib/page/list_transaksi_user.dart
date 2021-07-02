part of 'pages.dart';

class ListTransaksiUser extends StatefulWidget {
  @override
  _ListTransaksiUserState createState() => _ListTransaksiUserState();
}

class _ListTransaksiUserState extends State<ListTransaksiUser> {
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
            Text(
              "LIST TRANSAKSI",
              style: TextStyle(fontWeight: FontWeight.w900),
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
