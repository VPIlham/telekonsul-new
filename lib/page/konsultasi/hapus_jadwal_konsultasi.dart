part of '../pages.dart';

class HapusJadwalKonsultasi extends StatefulWidget {
  @override
  _HapusJadwalKonsultasiState createState() => _HapusJadwalKonsultasiState();
}

class _HapusJadwalKonsultasiState extends State<HapusJadwalKonsultasi> {
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
                  "SENIN",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 27),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 61,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(10),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "11.30-12.00",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icon_edit.png",
                          height: 48,
                          width: 50,
                        ),
                      ),
                      Image.asset(
                        "assets/icon_delete.png",
                        height: 48,
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 61,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(10),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "11.30-12.00",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icon_edit.png",
                          height: 48,
                          width: 50,
                        ),
                      ),
                      Image.asset(
                        "assets/icon_delete.png",
                        height: 48,
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 61,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(10),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "11.30-12.00",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icon_edit.png",
                          height: 48,
                          width: 50,
                        ),
                      ),
                      Image.asset(
                        "assets/icon_delete.png",
                        height: 48,
                        width: 50,
                      ),
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
