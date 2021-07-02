part of 'pages.dart';

class ListDokterSpesialis extends StatefulWidget {
  @override
  _ListDokterSpesialisState createState() => _ListDokterSpesialisState();
}

class _ListDokterSpesialisState extends State<ListDokterSpesialis> {
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
              "LIST DOKTER UMUM",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Container(
                  height: 146,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Card(
                    color: Color(0xffFBFBFB),
                    child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(13),
                              child: Image.asset(
                                "assets/profile_dokter.png",
                                width: 95,
                                height: 93,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "dr. Johnson ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "DOKTER UMUM",
                                    style: TextStyle(
                                        color: Color(0xffB1ABAB),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp. 50.000,-",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Container(
                                      height: 25,
                                      width: 121,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xffD11900),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "BOOKED",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Container(
                  height: 146,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Card(
                    color: Color(0xffFBFBFB),
                    child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(13),
                              child: Image.asset(
                                "assets/profile_dokter.png",
                                width: 95,
                                height: 93,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "dr. Johnson ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "DOKTER UMUM",
                                    style: TextStyle(
                                        color: Color(0xffB1ABAB),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp. 50.000,-",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Container(
                                      height: 25,
                                      width: 121,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xff0096D1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "BOOK",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
