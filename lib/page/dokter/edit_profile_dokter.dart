part of '../pages.dart';

class EditProfileDokter extends StatefulWidget {
  final Dokter dokter;
  const EditProfileDokter({Key key, @required this.dokter}) : super(key: key);

  @override
  _EditProfileDokterState createState() => _EditProfileDokterState();
}

class _EditProfileDokterState extends State<EditProfileDokter> {
  Dokter get dokter => widget.dokter;

  bool _isLoading = false;

  int _radioValue = 0;

  String _genderValue = 'Laki-Laki';

  String selectedSpesialis = "DOKTER UMUM";
  List<String> spesialis = [
    "DOKTER UMUM",
    "DOKTER BEDAH",
    "DOKTER GIGI",
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _txtNama = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtAlamat = TextEditingController();
  TextEditingController _txtNomor = TextEditingController();
  TextEditingController _txtSip = TextEditingController();
  TextEditingController _txtRekening = TextEditingController();

  FocusNode _fnNama = FocusNode();
  FocusNode _fnEmail = FocusNode();
  FocusNode _fnAlamat = FocusNode();
  FocusNode _fnNomor = FocusNode();
  FocusNode _fnSip = FocusNode();
  FocusNode _fnRekening = FocusNode();

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
    switch (_radioValue) {
      case 0:
        _genderValue = 'Laki-Laki';
        break;
      case 1:
        _genderValue = 'Perempuan';
        break;
    }
  }

  List<DropdownMenuItem> generateItems(List<String> spesialis) {
    List<DropdownMenuItem> items = [];
    for (var item in spesialis) {
      items.add(
        DropdownMenuItem(
          child: Text("$item"),
          value: item,
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    _txtNama.text = dokter.nama;
    _txtEmail.text = dokter.email;
    _txtAlamat.text = dokter.alamat;
    _txtNomor.text = dokter.noTelp;
    _txtSip.text = dokter.noSIP;
    _txtRekening.text = dokter.noRek;
    selectedSpesialis = dokter.spesialis;
    _radioValue = dokter.jenisKelamin == 'Laki-Laki' ? 0 : 1;
    _genderValue = dokter.jenisKelamin;
    super.initState();
  }

  @override
  void dispose() {
    _txtNama.dispose();
    _txtEmail.dispose();
    _txtAlamat.dispose();
    _txtNomor.dispose();
    _txtSip.dispose();
    _txtRekening.dispose();

    _fnNama.dispose();
    _fnEmail.dispose();
    _fnAlamat.dispose();
    _fnNomor.dispose();
    _fnSip.dispose();
    _fnRekening.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kembali"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
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
                                  "Edit Profile",
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Nama Lengkap",
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: _txtNama,
                                    focusNode: _fnNama,
                                    maxLength: 30,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      filled: true,
                                      counterText: "",
                                      fillColor: Colors.white,
                                      hintText: 'Nama Lengkap',
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
                                      FocusScope.of(context)
                                          .requestFocus(_fnNomor);
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Email",
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _txtEmail,
                                    focusNode: _fnEmail,
                                    readOnly: true,
                                    maxLength: 30,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      filled: true,
                                      counterText: "",
                                      fillColor: Colors.white,
                                      hintText: 'example@gmail.com',
                                      errorStyle: TextStyle(
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No. Telepon",
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    focusNode: _fnNomor,
                                    controller: _txtNomor,
                                    maxLength: 16,
                                    keyboardType: TextInputType.phone,
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
                                      hintText: 'No Telp',
                                      errorStyle: TextStyle(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Field ini tidak boleh kosong';
                                      }

                                      if (value.length < 10 ||
                                          value.length > 16) {
                                        return 'Tidak boleh kurang dari 10 atau lebih dari 16';
                                      }

                                      return null;
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(_fnAlamat);
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Alamat",
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    focusNode: _fnAlamat,
                                    controller: _txtAlamat,
                                    keyboardType: TextInputType.streetAddress,
                                    maxLength: 50,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      counterText: "",
                                      fillColor: Colors.white,
                                      hintText: 'Alamat',
                                      errorStyle: TextStyle(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Jenis Kelamin",
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 0,
                                        groupValue: _radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      Text(
                                        'Laki-Laki',
                                      ),
                                      Radio(
                                        value: 1,
                                        groupValue: _radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      Text(
                                        'Perempuan',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No. SIP (Surat Izin Praktik)",
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    focusNode: _fnSip,
                                    controller: _txtSip,
                                    keyboardType: TextInputType.text,
                                    maxLength: 50,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      counterText: "",
                                      fillColor: Colors.white,
                                      hintText: 'No. SIP',
                                      errorStyle: TextStyle(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Field ini tidak boleh kosong';
                                      }

                                      if (value.length <= 6) {
                                        return 'No. SIP harus lebih dari 6 karatker';
                                      }

                                      return null;
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Pilih Spesialis",
                                  ),
                                  const SizedBox(height: 4),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: selectedSpesialis,
                                        items: generateItems(spesialis),
                                        onChanged: (item) {
                                          setState(() {
                                            selectedSpesialis = item;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No. Rekening BCA",
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    focusNode: _fnRekening,
                                    controller: _txtRekening,
                                    keyboardType: TextInputType.text,
                                    maxLength: 14,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      counterText: "",
                                      fillColor: Colors.white,
                                      hintText: 'No. Rekening',
                                      errorStyle: TextStyle(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Field ini tidak boleh kosong';
                                      }

                                      if (value.length <= 9) {
                                        return 'No. Rekening harus lebih dari 9 karatker';
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

                                                await _editProfile();

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
                                              child: Text("Edit Profile"),
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
              ),
            );
          },
        ),
      ),
    );
  }

  _editProfile() async {
    if (!_formKey.currentState.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (_genderValue == "") {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Anda harus mengisi jenis kelamin"),
        ),
      );
      return;
    }

    if (selectedSpesialis == "") {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Anda harus memilih spesialis"),
        ),
      );
      return;
    }

    try {
      Map<String, dynamic> data = {
        'doc_id': dokter.uid,
        'nama': _txtNama.text,
        'email': _txtEmail.text,
        'noTelp': _txtNomor.text,
        'alamat': _txtAlamat.text,
        'jenis_kelamin': _genderValue,
        'no_sip': _txtSip.text,
        'spesialis': selectedSpesialis,
        'no_rek': _txtRekening.text,
        'is_busy': false,
        'profile_url': dokter.profileUrl,
      };

      await FirebaseFirestore.instance.doc('dokter/${dokter.uid}').update(data);

      Dokter newData = Dokter.fromJson(data);
      Provider.of<DokterProvider>(context, listen: false).setDokter = newData;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
  }
}
