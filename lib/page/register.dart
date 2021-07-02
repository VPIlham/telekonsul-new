part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nomorController = TextEditingController();
  bool _success;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference users = firestore.collection('users');
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            Image.asset("assets/register.png"),
            SizedBox(
              height: 24,
            ),
            Form(
              key: _formKey,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    color: Color(0xffC62644),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                          child: Text("Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 30, left: 30),
                      child: Column(
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Nama",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Center(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: namaController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'masukan email Anda',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 30, left: 30),
                      child: Column(
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Center(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'masukan email Anda',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 30, left: 30),
                      child: Column(
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Alamat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Center(
                                  child: TextFormField(
                                    controller: alamatController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'masukan alamat Anda',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 30, left: 30),
                      child: Column(
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " No. Telepon",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Center(
                                  child: TextFormField(
                                    controller: nomorController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'masukan nomor telepon Anda',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 30, left: 30),
                      child: Column(
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Center(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'masukan password Anda',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: 149,
                      height: 46,
                      child: RaisedButton(
                        onPressed: () async {
                          if (!(namaController.text.trim() != "" &&
                              emailController.text.trim() != "" &&
                              passwordController.text.trim() != "" &&
                              nomorController.text.trim() != "")) {
                            Flushbar(
                              duration: Duration(seconds: 4),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Mohon isi semua kolom!",
                            )..show(context);
                          } else if (!(emailController.text.trim() != "" &&
                              passwordController.text.trim() != "")) {
                            Flushbar(
                              duration: Duration(seconds: 4),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "emai dan password wajib diisi!",
                            )..show(context);
                          } else if (!EmailValidator.validate(
                              emailController.text)) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Format email salah",
                            ).show(context);
                          } else {
                            // users.add({
                            //   'nama': namaController.text,
                            //   'email': emailController.text,
                            //   'password': passwordController.text,
                            //   'alamat': alamatController.text,
                            //   'nomor_telp': nomorController.text
                            // });
                            await _register();

                            namaController.text = '';
                            emailController.text = '';
                            passwordController.text = '';
                            alamatController.text = '';
                            nomorController.text = '';

                            Flushbar(
                              duration: Duration(seconds: 4),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Daftar Berhasil",
                            )..show(context);
                          }
                        },
                        child: Text("DAFTAR"),
                        color: Color(0xffF3AC61),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ])),
            )
          ],
        ),
      ),
    );
    // Example code for registration.
  }

  Future<void> _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }
}
