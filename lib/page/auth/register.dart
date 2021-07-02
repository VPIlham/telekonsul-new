part of '../pages.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _txtNama = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  TextEditingController _txtAlamat = TextEditingController();
  TextEditingController _txtNomor = TextEditingController();

  FocusNode _fnNama = FocusNode();
  FocusNode _fnEmail = FocusNode();
  FocusNode _fnPassword = FocusNode();
  FocusNode _fnAlamat = FocusNode();
  FocusNode _fnNomor = FocusNode();

  bool _isLoading = false;

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
  void dispose() {
    _txtNama.dispose();
    _txtEmail.dispose();
    _txtPassword.dispose();
    _txtAlamat.dispose();
    _txtNomor.dispose();

    _fnNama.dispose();
    _fnEmail.dispose();
    _fnPassword.dispose();
    _fnAlamat.dispose();
    _fnNomor.dispose();
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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset("assets/register.png"),
                  Container(
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
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 56),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Lengkap",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _txtNama,
                                focusNode: _fnNama,
                                maxLength: 30,
                                textCapitalization: TextCapitalization.words,
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
                                  FocusScope.of(context).requestFocus(_fnEmail);
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _txtEmail,
                                focusNode: _fnEmail,
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field ini tidak boleh kosong';
                                  }

                                  if (!EmailValidator.validate(value)) {
                                    return 'Masukkan email dengan benar';
                                  }

                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_fnPassword);
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Password",
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field ini tidak boleh kosong';
                                  }

                                  if (value.length <= 6) {
                                    return 'Password harus lebih dari 6 karatker';
                                  }

                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_fnNomor);
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No Telp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4.0),
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

                                  if (value.length < 10 || value.length > 16) {
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
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4.0),
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Container(
                                height: height / 18,
                                width: width / 2.5,
                                child: MaterialButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    if (!_formKey.currentState.validate()) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      return;
                                    }

                                    try {
                                      final dataAuth = await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                        email: _txtEmail.text,
                                        password: _txtPassword.text,
                                      );

                                      Map<String, dynamic> data = {
                                        'doc_id': dataAuth.user.uid,
                                        'nama': _txtNama.text,
                                        'email': _txtEmail.text,
                                        'noTelp': _txtNomor.text,
                                        'alamat': _txtAlamat.text,
                                        'profile_url': "",
                                      };

                                      await FirebaseFirestore.instance
                                          .doc('users/${dataAuth.user.uid}')
                                          .set(
                                            data,
                                            SetOptions(merge: true),
                                          );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Register berhasil, redirecting..."),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Terjadi kesalahan"),
                                        ),
                                      );
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      return;
                                    }

                                    if (this.mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      return;
                                    }
                                  },
                                  child: Text("DAFTAR"),
                                  color: Color(0xffF3AC61),
                                ),
                              ),
                        const SizedBox(height: 32),
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
