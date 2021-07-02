part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView(children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Hello, Ilham",
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
                    Image.asset("assets/homepage.png"),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Jadwal Dokter Hari Ini",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 146,
                                margin: EdgeInsets.only(bottom: 10, right: 8),
                                child: Card(
                                  color: Color(0xffFBFBFB),
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      print('Card tapped.');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Rp. 50.000,-",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: 11,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 121,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xffD11900),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "BOOKED",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 146,
                                margin: EdgeInsets.only(bottom: 10, right: 8),
                                child: Card(
                                  color: Color(0xffFBFBFB),
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      print('Card tapped.');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Rp. 50.000,-",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: 11,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 121,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xff0096D1),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "BOOK",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Spesialisasi Dokter",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      height: 117,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.all(10),
                            width: 105,
                            decoration: BoxDecoration(
                              color: Color(0xffFBFBFB),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 1), // // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/dokter_umum.png",
                                  height: 73,
                                  width: 68,
                                ),
                                Text(
                                  "DOKTER UMUM",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.all(10),
                            width: 105,
                            decoration: BoxDecoration(
                              color: Color(0xffFBFBFB),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 1), //  changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/dokter_gigi.png",
                                  height: 73,
                                  width: 68,
                                ),
                                Text(
                                  "DOKTER GIGI",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.all(10),
                            width: 105,
                            decoration: BoxDecoration(
                              color: Color(0xffFBFBFB),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 1), //  changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/dokter_bedah.png",
                                  height: 73,
                                  width: 68,
                                ),
                                Text(
                                  "DOKTER BEDAH",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
