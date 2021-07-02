part of '../pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isDokter = false;

  var size;
  var height;
  var width;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 4.0),
            Image.asset(
              "assets/homesplash.png",
              fit: BoxFit.cover,
              height: 235,
              width: double.infinity,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xffC62644),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "SELAMAT DATANG",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Kini semakin mudah pasien yang ingin konsultasi tatap muka dengan dokter tanpa harus meninggalkan rumah.",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "PILIH",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: false,
                              groupValue: _isDokter,
                              onChanged: (value) => setState(() {
                                _isDokter = value;
                              }),
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                            ),
                            Text(
                              'Pasien',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(width: 4.0),
                            Radio(
                              value: true,
                              groupValue: _isDokter,
                              onChanged: (value) => setState(() {
                                _isDokter = value;
                              }),
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                            ),
                            Text(
                              'Dokter',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: Container(
                            height: height / 16,
                            width: width / 3,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage(isDokter: _isDokter),
                                  ),
                                );
                              },
                              child: Text(
                                "MULAI",
                              ),
                              color: Color(0xffF3AC61),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
