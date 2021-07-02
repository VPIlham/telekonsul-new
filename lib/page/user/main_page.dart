part of '../pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var size;
  var height;
  var width;

  var currentUser;

  @override
  void initState() {
    Provider.of<DokterProvider>(context, listen: false).getAllDokter(
        Provider.of<UserProvider>(context, listen: false).user.uid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    currentUser = Provider.of<UserProvider>(context).user;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hello, ${currentUser.nama}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 24),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                      backgroundImage: currentUser.profileUrl != ""
                          ? NetworkImage(currentUser.profileUrl)
                          : null,
                      child: currentUser.profileUrl != ""
                          ? null
                          : Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                    ),
                  ],
                ),
                Image.asset("assets/homepage.png"),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal Dokter Hari Ini",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Consumer<DokterProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (value.listDokter.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tidak ada dokter yang buka hari ini"),
                      );
                    }

                    return Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: value.listDokter.length,
                        itemBuilder: (context, index) {
                          final item = value.listDokter[index];
                          final itemKonsultasi = item.jadwalKonsultasi
                              .where((element) =>
                                  element.hari.intValue ==
                                  DateTime.now().weekday)
                              .first;

                          return Container(
                            height: 146,
                            margin: EdgeInsets.only(bottom: 10, right: 8),
                            child: Card(
                              elevation: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: item.dokter.profileUrl !=
                                            ""
                                        ? NetworkImage(item.dokter.profileUrl)
                                        : null,
                                    child: item.dokter.profileUrl != ""
                                        ? null
                                        : Center(
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(13),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.dokter.nama}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${item.dokter.spesialis}",
                                          style: TextStyle(
                                              color: Color(0xffB1ABAB),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Rp. ${NumberFormat("#,###").format(itemKonsultasi.harga)},-",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(
                                          height: 11,
                                        ),
                                        item.dokter.isBusy
                                            ? Container(
                                                height: 25,
                                                width: 121,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.deepOrange,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Sedang Konsultasi",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            : item.isBooked
                                                ? Container(
                                                    height: 25,
                                                    width: 121,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xffD11900),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "BOOKED",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 25,
                                                    width: 121,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xff0096D1),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailKonsultasi(
                                                              dataDokter: item,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          "BOOK",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Spesialisasi Dokter",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 140,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 115,
                          child: Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListDokterSpesialis(
                                      spesialis: "DOKTER UMUM"),
                                ));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/dokter_umum.png",
                                    height: 73,
                                    width: 68,
                                  ),
                                  Text(
                                    "Dokter Umum",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 115,
                          child: Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListDokterSpesialis(
                                      spesialis: "DOKTER GIGI"),
                                ));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/dokter_gigi.png",
                                    height: 73,
                                    width: 68,
                                  ),
                                  Text(
                                    "Dokter Gigi",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 115,
                          child: Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListDokterSpesialis(
                                      spesialis: "DOKTER BEDAH"),
                                ));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/dokter_bedah.png",
                                    height: 73,
                                    width: 68,
                                  ),
                                  Text(
                                    "Dokter Bedah",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 50,
                  child: Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ListDiagnosisUser(),
                        ));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Container(
                              color: Colors.blue,
                              child: Icon(
                                Icons.list,
                                color: Colors.white,
                              )),
                          SizedBox(width: 30),
                          Text("List Catatan Dokter",
                              style: TextStyle(fontSize: 11))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
