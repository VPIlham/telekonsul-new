part of '../pages.dart';

class EditAntrian extends StatefulWidget {
  final Antrian antrian;
  const EditAntrian({Key key, @required this.antrian}) : super(key: key);

  @override
  _EditAntrianState createState() => _EditAntrianState();
}

class _EditAntrianState extends State<EditAntrian> {
  Antrian get antrian => widget.antrian;

  bool _isLoading = false;

  TextEditingController _txtNama = TextEditingController();
  TextEditingController _txtNoTelp = TextEditingController();
  TextEditingController _txtNomor = TextEditingController();

  FocusNode _fnNama = FocusNode();
  FocusNode _fnNoTelp = FocusNode();
  FocusNode _fnNomor = FocusNode();

  @override
  void initState() {
    _txtNama.text = antrian.dataTransaksi.createdBy.nama;
    _txtNoTelp.text = antrian.dataTransaksi.createdBy.noTelp;
    _txtNomor.text = antrian.nomorAntrian.toString();
    super.initState();
  }

  @override
  void dispose() {
    _txtNama.dispose();
    _txtNoTelp.dispose();
    _txtNomor.dispose();

    _fnNama.dispose();
    _fnNoTelp.dispose();
    _fnNomor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kembali"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: Card(
                          color: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Ubah Antrian",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("Nama"),
                              const SizedBox(height: 4.0),
                              TextFormField(
                                focusNode: _fnNama,
                                controller: _txtNama,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Text("No. Telp"),
                              const SizedBox(height: 4.0),
                              TextFormField(
                                focusNode: _fnNoTelp,
                                controller: _txtNoTelp,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Text("Nomor Antrian"),
                              const SizedBox(height: 4.0),
                              TextFormField(
                                focusNode: _fnNomor,
                                controller: _txtNomor,
                                maxLength: 16,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  counterText: "",
                                  fillColor: Colors.white,
                                  hintText: 'Nomor Antrian',
                                  errorStyle: TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field ini tidak boleh kosong';
                                  }

                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              const SizedBox(height: 22.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _isLoading
                                      ? CircularProgressIndicator()
                                      : MaterialButton(
                                          onPressed: () async {
                                            setState(() {
                                              _isLoading = true;
                                            });

                                            await _ubahAntrian();

                                            setState(() {
                                              _isLoading = false;
                                            });

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Nomor antrian berhasil diubah"),
                                              ),
                                            );

                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Ubah"),
                                          color: Colors.deepOrange,
                                          textColor: Colors.white,
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _ubahAntrian() async {
    int nomorAntrian = int.tryParse(_txtNomor.text);
    if (nomorAntrian == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("nomoAntrian tidak boleh 0"),
        ),
      );
      return;
    }

    await Provider.of<AntrianProvider>(context, listen: false)
        .updateNomorAntrian(
      dokterId: FirebaseAuth.instance.currentUser.uid,
      antrianId: antrian.docId,
      nomor: nomorAntrian,
    );
    await Provider.of<AntrianProvider>(context, listen: false)
        .getAllAntrian(FirebaseAuth.instance.currentUser.uid);
  }
}
