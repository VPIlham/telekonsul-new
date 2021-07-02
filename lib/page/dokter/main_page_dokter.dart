part of '../pages.dart';

class MainPageDokter extends StatefulWidget {
  @override
  _MainPageDokterState createState() => _MainPageDokterState();
}

class _MainPageDokterState extends State<MainPageDokter> {
  var size;
  var height;
  var width;

  var currentUser;

  @override
  void initState() {
    Provider.of<AntrianProvider>(context, listen: false)
        .get7Antrian(FirebaseAuth.instance.currentUser.uid);
    Provider.of<PasienProvider>(context, listen: false)
        .get7Pasien(FirebaseAuth.instance.currentUser.uid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    currentUser = Provider.of<DokterProvider>(context).dokter;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                size: 16,
                              ),
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Antrian Masuk Hari Ini",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 17,
                ),
                Consumer<AntrianProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (value.listAntrian.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tidak ada antrian hari ini"),
                      );
                    }

                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.listAntrian.length,
                        itemBuilder: (context, index) {
                          final item = value.listAntrian[index];

                          return _antrianCard(item);
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "List Pasien",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                Consumer<PasienProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (value.pasien.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tidak ada data pasien"),
                      );
                    }

                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.pasien.length,
                        itemBuilder: (context, index) {
                          final item = value.pasien[index];

                          return _pasienCard(item);
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Kelola",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddJadwalKonsultasi(),
                        ),
                      );
                    },
                    leading: Image.asset(
                      "assets/icon_plus.png",
                      height: 36,
                      width: 36,
                      fit: BoxFit.cover,
                    ),
                    title: Text("Buat jadwal konsultasi Anda"),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ListJadwalKonsultasi(),
                        ),
                      );
                    },
                    leading: Image.asset(
                      "assets/icon_list.png",
                      height: 36,
                      width: 36,
                      fit: BoxFit.cover,
                    ),
                    title: Text("List jadwal konsultasi Anda"),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ListPasien(),
                        ),
                      );
                    },
                    leading: Image.asset(
                      "assets/icon_users.png",
                      height: 36,
                      width: 36,
                      fit: BoxFit.cover,
                    ),
                    title: Text("List pasien Anda"),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ListAntrianDokter()),
                      );
                    },
                    leading: Image.asset(
                      "assets/icon_list_antrian.png",
                      height: 36,
                      width: 36,
                      fit: BoxFit.cover,
                    ),
                    title: Text("List antrian pasien Anda"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pasienCard(UserModel item) {
    return Container(
      margin: EdgeInsets.only(top: 12, right: 10, bottom: 12, left: 10),
      padding: EdgeInsets.all(10),
      width: 160,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey,
                  backgroundImage: item.profileUrl != ""
                      ? NetworkImage(item.profileUrl)
                      : null,
                  child: item.profileUrl != ""
                      ? null
                      : Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${item.nama}",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _antrianCard(Antrian item) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 5),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey,
                backgroundImage: item.dataTransaksi.createdBy.profileUrl != ""
                    ? NetworkImage(item.dataTransaksi.createdBy.profileUrl)
                    : null,
                child: item.dataTransaksi.createdBy.profileUrl != ""
                    ? null
                    : Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.dataTransaksi.createdBy.nama}",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Rp. ${NumberFormat("#,###").format(item.dataTransaksi.jadwalKonsultasi.harga)},-",
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    // color: Color(0xffF6E11C),
                    color: Colors.amber,
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${item.dataTransaksi.jadwalKonsultasi.jamMulai.format(context)} - ${item.dataTransaksi.jadwalKonsultasi.jamAkhir.format(context)}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KonsultasiPage(
                          antrian: item,
                        ),
                      ),
                    );
                  },
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Text("Mulai Konsultasi"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
