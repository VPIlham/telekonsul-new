part of '../pages.dart';

class LoginPage extends StatefulWidget {
  final bool isDokter;
  const LoginPage({Key key, @required this.isDokter}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _emailBenar = false;
  bool _passBenar = false;

  var size;
  var height;
  var width;

  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  FocusNode _fnEmail = FocusNode();
  FocusNode _fnPassword = FocusNode();

  bool get isDokter => widget.isDokter;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _txtEmail.dispose();
    _txtPassword.dispose();

    _fnEmail.dispose();
    _fnPassword.dispose();
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/login.png"),
                  const SizedBox(height: 16.0),
                  Container(
                    height: height * 0.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      color: Color(0xffC62644),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 56),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                focusNode: _fnEmail,
                                controller: _txtEmail,
                                maxLength: 30,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  filled: true,
                                  counterText: "",
                                  fillColor: Colors.white,
                                  hintText: 'email@example.com',
                                  errorStyle: TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (EmailValidator.validate(value) &&
                                      !_emailBenar) {
                                    setState(() {
                                      _emailBenar = true;
                                    });
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    _emailBenar = EmailValidator.validate(
                                      value,
                                    );
                                  });
                                  FocusScope.of(context)
                                      .requestFocus(_fnPassword);
                                },
                              ),
                              const SizedBox(height: 20),
                              Text(
                                " Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                focusNode: _fnPassword,
                                controller: _txtPassword,
                                maxLength: 16,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  counterText: "",
                                  fillColor: Colors.white,
                                  hintText: 'Password',
                                  errorStyle: TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.length > 6 && !_passBenar) {
                                    setState(() {
                                      _passBenar = true;
                                    });
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  if (value.length > 6) {
                                    setState(() {
                                      _passBenar = true;
                                    });
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Atau",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            InkWell(
                              onTap: () {
                                if (isDokter) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterDokterPage(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Daftar Baru",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height / 16,
                        ),
                        _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Container(
                                width: width / 2.5,
                                height: height / 18,
                                child: MaterialButton(
                                  onPressed: _emailBenar && _passBenar
                                      ? () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          if (!_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            return;
                                          }

                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: _txtEmail.text,
                                                    password:
                                                        _txtPassword.text);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Login berhasil, redirecting..."),
                                              ),
                                            );
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Email atau password salah"),
                                              ),
                                            );
                                          }

                                          if (this.mounted) {
                                            setState(() {
                                              _isLoading = false;
                                              _emailBenar = false;
                                              _passBenar = false;
                                              _txtPassword.clear();
                                              _txtEmail.clear();
                                            });
                                          }
                                        }
                                      : null,
                                  child: Text("MASUK"),
                                  color: Color(0xffF3AC61),
                                  disabledColor: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: height / 36.6,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
