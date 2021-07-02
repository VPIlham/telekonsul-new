part of '../pages.dart';

class ListTransaksiUser extends StatefulWidget {
  @override
  _ListTransaksiUserState createState() => _ListTransaksiUserState();
}

class _ListTransaksiUserState extends State<ListTransaksiUser> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  List<Transaksi> _searchResult = [];

  bool _isEmpty = false;

  @override
  void initState() {
    Provider.of<TransaksiProvider>(context, listen: false).getAllTransaksi(
        false, Provider.of<UserProvider>(context, listen: false).user.uid);
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
      body: SafeArea(
        child: Consumer<TransaksiProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (value.listTransaksi.isEmpty) {
              return Center(
                child: Text("Anda belum pernah melakukan transaksi"),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    "List Transaksi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
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
                      hintText: "Cari Transaksi by Status",
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
                      value.listTransaksi.forEach((element) {
                        if (element.status.contains(query)) {
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
                  const SizedBox(height: 16.0),
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

                                    return _transaksiCard(item);
                                  },
                                  itemCount: _searchResult.toSet().length,
                                  shrinkWrap: true,
                                )
                              : ListView.builder(
                                  itemCount: value.listTransaksi.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final item = value.listTransaksi[index];

                                    return _transaksiCard(item);
                                  },
                                ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _transaksiCard(Transaksi item) {
    return Card(
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TransaksiDetail(transaksi: item),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Transaksi ID #${item.docId}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${DateFormat("dd MMMM yyyy").format(item.createdAt)}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BANK : ",
                    style: TextStyle(),
                  ),
                  Text(
                    "BCA",
                    style: TextStyle(),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL : ",
                    style: TextStyle(),
                  ),
                  Text(
                    "Rp. ${NumberFormat("#,###").format(item.jadwalKonsultasi.harga)},-",
                    style: TextStyle(),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STATUS : ",
                    style: TextStyle(),
                  ),
                  StatusText(text: item.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
