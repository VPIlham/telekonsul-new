part of 'pages.dart';

class ListPasien extends StatefulWidget {
  @override
  _ListPasienState createState() => _ListPasienState();
}

class _ListPasienState extends State<ListPasien> {
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
                  "LIST PASIEN",
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
              height: 100,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama : Otang",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Alamat : jl jalsjdasdla asd as",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Nomor telp : 08977166220",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              height: 100,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama : Otang",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Alamat : jl jalsjdasdla asd as",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Nomor telp : 08977166220",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
