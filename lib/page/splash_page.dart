part of 'pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/homesplash.png",
              fit: BoxFit.cover,
              height: 275,
              width: double.infinity,
            ),
            Container(
              // height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(0xffC62644),
              ),
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SELAMAT DATANG",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Kini semakin mudah pasien yang ingin\nkonsultasi tatap muka dengan dokter\ntanpa harus meninggalkan rumah.",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "PILIH",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("PASIEN", style: TextStyle(color: Colors.white)),
                        Text("DOKTER", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: 46,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Color(0xffF3AC61),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            "MULAI",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
