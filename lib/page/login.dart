part of 'pages.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Image.asset("assets/login.png"),
            Container(
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
                        child: Text("LOGIN",
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
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'email@example.com',
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
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'email@example.com',
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
                          const EdgeInsets.only(top: 15, right: 30, left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Text(
                              "Atau \nDaftar Baru",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    width: 149,
                    height: 46,
                    child: RaisedButton(
                      onPressed: () {
                        Flushbar(
                          duration: Duration(seconds: 4),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Login Berhasil",
                        )..show(context);
                      },
                      child: Text("LOGIN"),
                      color: Color(0xffF3AC61),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
