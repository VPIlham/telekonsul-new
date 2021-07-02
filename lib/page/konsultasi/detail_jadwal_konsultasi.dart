part of '../pages.dart';

class DetailJadwalKonsultasi extends StatefulWidget {
  final JadwalKonsultasi jadwal;
  const DetailJadwalKonsultasi({Key key, @required this.jadwal})
      : super(key: key);

  @override
  _DetailJadwalKonsultasiState createState() => _DetailJadwalKonsultasiState();
}

class _DetailJadwalKonsultasiState extends State<DetailJadwalKonsultasi> {
  JadwalKonsultasi get jadwal => widget.jadwal;

  List<Hari> _day = [
    Hari(
      'Senin',
      1,
    ),
    Hari(
      'Selasa',
      2,
    ),
    Hari(
      'Rabu',
      3,
    ),
    Hari(
      'Kamis',
      4,
    ),
    Hari(
      'Jumat',
      5,
    ),
    Hari(
      'Sabtu',
      6,
    ),
    Hari(
      'Minggu',
      7,
    ),
  ];

  Hari _selectedDay;

  TimeOfDay _startTime;
  TimeOfDay _endTime;

  TextEditingController _txtPrice = TextEditingController();
  FocusNode _fnPrice = FocusNode();

  bool _isLoading = false;

  _selectTime(BuildContext context) async {
    TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _startTime = pickedTime;
        _endTime = pickedTime.replacing(
          hour: pickedTime.hour,
          minute: pickedTime.minute + 30,
        );
      });
    }
  }

  Dokter currentDokter;

  @override
  void initState() {
    currentDokter = Provider.of<DokterProvider>(context, listen: false).dokter;
    _selectedDay =
        _day.firstWhere((element) => element.intValue == jadwal.hari.intValue);
    _startTime = jadwal.jamMulai;
    _endTime = jadwal.jamAkhir;
    _txtPrice.text = NumberFormat("#,###").format(jadwal.harga);
    super.initState();
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
                                "Ubah Jadwal",
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
                                Text("Pilih Hari"),
                                const SizedBox(height: 4.0),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: DropdownButton<Hari>(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      value: _selectedDay,
                                      items: generateItems(_day),
                                      onChanged: (item) {
                                        setState(() {
                                          _selectedDay = item;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                Text("Jam"),
                                const SizedBox(height: 4.0),
                                MaterialButton(
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  onPressed: () async =>
                                      await _selectTime(context),
                                  child: _startTime != null
                                      ? Text(
                                          "${_startTime.format(context)} - ${_endTime.format(context)}")
                                      : Text("Pilih Jam"),
                                ),
                                const SizedBox(height: 12.0),
                                Text("Harga"),
                                const SizedBox(height: 4.0),
                                TextFormField(
                                  focusNode: _fnPrice,
                                  controller: _txtPrice,
                                  maxLength: 16,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    NumericTextFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    counterText: "",
                                    fillColor: Colors.white,
                                    hintText: 'Harga',
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
                                        : Row(
                                            children: [
                                              MaterialButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  await _hapusJadwal();
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                },
                                                child: Text("Hapus"),
                                                color: Colors.red,
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
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              MaterialButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  await _ubahJadwal();
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
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
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ],
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
                )),
          );
        },
      ),
    );
  }

  List<DropdownMenuItem<Hari>> generateItems(List<Hari> days) {
    List<DropdownMenuItem<Hari>> items = [];
    for (var day in days) {
      items.add(
        DropdownMenuItem(
          child: Text("${day.day}"),
          value: day,
        ),
      );
    }
    return items;
  }

  _ubahJadwal() async {
    NumberFormat format = NumberFormat();

    DateTime now = DateTime.now();
    DateTime jamMulai = DateTime(now.year, now.month, now.day, _startTime.hour, _startTime.minute);
    DateTime jamAkhir = DateTime(now.year, now.month, now.day, _endTime.hour, _endTime.minute);

    Map<String, dynamic> data = {
      'hari': _selectedDay.toJson(),
      'jam_mulai': DateFormat("hh:mm a").format(jamMulai),
      'jam_akhir': DateFormat("hh:mm a").format(jamAkhir),
      'harga': format.parse(_txtPrice.text),
    };

    try {
      await Provider.of<JadwalKonsultasiProvider>(context, listen: false)
          .updateJadwalKonsultasi(jadwal.docId, data, currentDokter.uid);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil mengubah jadwal"),
        ),
      );

      await Provider.of<JadwalKonsultasiProvider>(context, listen: false)
          .getListJadwalKonsultasi(currentDokter.uid);

      Navigator.of(context).pop();
    } catch (e) {
      print("Something went wrong:" + e.toString());
    }
  }

  _hapusJadwal() async {
    try {
      await Provider.of<JadwalKonsultasiProvider>(context, listen: false)
          .deleteJadwalKonsultasi(jadwal.docId, currentDokter.uid);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil menghapus jadwal"),
        ),
      );

      await Provider.of<JadwalKonsultasiProvider>(context, listen: false)
          .getListJadwalKonsultasi(currentDokter.uid);

      Navigator.of(context).pop();
    } catch (e) {
      print("Something went wrong:" + e.toString());
    }
  }
}
