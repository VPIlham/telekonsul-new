part of 'pages.dart';

class KonsultasiPage extends StatefulWidget {
  @override
  _KonsultasiPageState createState() => _KonsultasiPageState();
}

class _KonsultasiPageState extends State<KonsultasiPage> {
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
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TRANSAKSI ID #1123123122",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text(
                  "20 APRIL 2021",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RP. 50.000,-",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 23,
                  width: 101,
                  decoration: BoxDecoration(
                    color: Color(0xffF6E11C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "12.30-12.30",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/avatar_user.png",
                  width: 99,
                  height: 93,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Agan Paralon",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ketika Anda mengklik MULAI\nAnda sedang melakukan KONSULTASI",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  width: 111,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xff619BF2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "MULAI",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 111,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xffE95E5E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "SELESAI",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
