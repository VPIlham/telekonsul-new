part of '../pages.dart';

class ListDokterSpesialis extends StatefulWidget {
  final String spesialis;
  const ListDokterSpesialis({Key key, @required this.spesialis})
      : super(key: key);

  @override
  _ListDokterSpesialisState createState() => _ListDokterSpesialisState();
}

class _ListDokterSpesialisState extends State<ListDokterSpesialis> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  List<DataDokter> _searchResult = [];

  bool _isEmpty = false;

  @override
  void initState() {
    Provider.of<DokterProvider>(context, listen: false).getSpesialisDokter(
      widget.spesialis,
      Provider.of<UserProvider>(context, listen: false).user.uid,
    );
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kembali"),
      ),
      body: Consumer<DokterProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.listSpesialisDokter.isEmpty) {
            return Center(child: Text("Tidak ada dokter yang buka hari ini"));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                Text(
                  "List ${widget.spesialis}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                            _focusNode.unfocus();
                            _searchResult.clear();
                            _isEmpty = false;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: "Cari Dokter",
                  ),
                  onChanged: (query) {
                    if (query.isEmpty || query == "") {
                      setState(() {
                        _searchResult.clear();
                        _isEmpty = false;
                      });
                      return;
                    }

                    _searchResult.clear();
                    value.listSpesialisDokter.forEach((element) {
                      if (element.dokter.nama.contains(query)) {
                        setState(() {
                          _searchResult.add(element);
                          _isEmpty = false;
                          return;
                        });
                      }
                    });

                    if (_searchResult.isEmpty) {
                      setState(() {
                        _isEmpty = true;
                      });
                    }
                  },
                ),
                const SizedBox(height: 8.0),
                _isEmpty
                    ? Center(
                        child: Text("Hasil searching transaksi kosong"),
                      )
                    : Expanded(
                        child: _searchResult.isNotEmpty &&
                                _controller.text.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  final item =
                                      _searchResult.toSet().toList()[index];

                                  return dokterCard(item);
                                },
                                itemCount: _searchResult.toSet().length,
                                shrinkWrap: true,
                              )
                            : ListView.builder(
                                itemCount: value.listSpesialisDokter.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final item = value.listSpesialisDokter[index];

                                  return dokterCard(item);
                                },
                              ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  dokterCard(DataDokter item) {
    return Container(
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
              backgroundImage: item.dokter.profileUrl != ""
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.dokter.nama}",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
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
                    "Rp. ${item.jadwalKonsultasi[0] != null ? NumberFormat("#,###").format(item.jadwalKonsultasi[0].harga) : 0},-",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  item.dokter.isBusy
                      ? Container(
                          height: 25,
                          width: 121,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepOrange,
                          ),
                          child: Center(
                            child: Text(
                              "Sedang Konsultasi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : item.isBooked
                          ? Container(
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
                              ),
                            )
                          : Container(
                              height: 25,
                              width: 121,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff0096D1),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailKonsultasi(
                                        dataDokter: item,
                                      ),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "BOOK",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
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
  }
}
