part of 'pages.dart';

class ListAntrianDokter extends StatefulWidget {
  @override
  _ListAntrianDokterState createState() => _ListAntrianDokterState();
}

class _ListAntrianDokterState extends State<ListAntrianDokter> {
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
                  "LIST ANTRIAN",
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
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              height: 115,
              decoration: BoxDecoration(
                color: Color(0xffFBFBFB),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/avatar_user.png",
                    height: 93,
                    width: 95,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama : Otang",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Nomor : 08977166222",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Container(
                        height: 20,
                        width: 85,
                        margin: EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: Color(0xffF6E11C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text("11.30-12.00",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 12)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 20,
                            width: 138,
                            decoration: BoxDecoration(
                              color: Color(0xff619BF2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "SENIN, 27-05-2021",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff301EFE),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              height: 115,
              decoration: BoxDecoration(
                color: Color(0xffFBFBFB),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/avatar_user.png",
                    height: 93,
                    width: 95,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama : Otang",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Nomor : 08977166222",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Container(
                        height: 20,
                        width: 85,
                        margin: EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: Color(0xffF6E11C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text("11.30-12.00",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 12)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 20,
                            width: 138,
                            decoration: BoxDecoration(
                              color: Color(0xff619BF2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "SENIN, 27-05-2021",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              "2",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff301EFE),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
