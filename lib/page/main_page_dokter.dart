part of 'pages.dart';

class MainPageDokter extends StatefulWidget {
  @override
  _MainPageDokterState createState() => _MainPageDokterState();
}

class _MainPageDokterState extends State<MainPageDokter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Hello, dr Ilham",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 27),
                        child: Image.asset(
                          "assets/user.png",
                          height: 32,
                          width: 32,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Antrian Masuk Hari Ini",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                    height: 155,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 17, right: 10, bottom: 17, left: 10),
                          padding: EdgeInsets.all(10),
                          width: 265,
                          decoration: BoxDecoration(
                            color: Color(0xffFBFBFB),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/avatar_user.png",
                                height: 93,
                                width: 99,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Agan Paralon AAA",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp. 50.000,-",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 23,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF6E11C),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "11.30-12.00",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Color(0xff0096D1),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Mulai Konsultasi",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 17, right: 10, bottom: 17, left: 10),
                          padding: EdgeInsets.all(10),
                          width: 265,
                          decoration: BoxDecoration(
                            color: Color(0xffFBFBFB),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/avatar_user.png",
                                height: 93,
                                width: 99,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Agan Paralon AAA",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp. 50.000,-",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 23,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF6E11C),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "11.30-12.00",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Color(0xff0096D1),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Mulai Konsultasi",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "List Pasien",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Container(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 17, right: 10, bottom: 17, left: 10),
                          padding: EdgeInsets.all(10),
                          width: 160,
                          decoration: BoxDecoration(
                            color: Color(0xffFBFBFB),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/avatar_user.png",
                                    height: 44,
                                    width: 44,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Agan Paralon",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 17, right: 10, bottom: 17, left: 10),
                          padding: EdgeInsets.all(10),
                          width: 160,
                          decoration: BoxDecoration(
                            color: Color(0xffFBFBFB),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/avatar_user.png",
                                    height: 44,
                                    width: 44,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Agan Paralon",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Kelola",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xffFBFBFB),
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icon_plus.png",
                              height: 54,
                              width: 52,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("Buat jadwal konsultasi Anda"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xffFBFBFB),
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icon_list.png",
                              height: 54,
                              width: 52,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("List jadwal konsultasi Anda"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xffFBFBFB),
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icon_users.png",
                              height: 54,
                              width: 52,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("List pasien Anda"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xffFBFBFB),
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icon_list_antrian.png",
                              height: 54,
                              width: 52,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("List antrian pasien Anda"),
                            )
                          ],
                        ),
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
