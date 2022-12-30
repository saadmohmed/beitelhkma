import 'package:book_shop/Wrapper.dart';
import 'package:book_shop/pages/register.dart';
import 'package:book_shop/services/ApiProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final storage = new FlutterSecureStorage();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Column(
          children: [
            //to give space from top
            const Expanded(
              flex: 1,
              child: Center(),
            ),

            //page content here
            Expanded(
              flex: 9,
              child: buildCard(context, size),
            ),
          ],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget buildCard(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //header text
              Text(
                'تسجيل دخول',
                style: new TextStyle(fontFamily: 'cairo',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color:const Color(0xFF21899C),
                  letterSpacing: 2.000000061035156,

                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              SizedBox(
                height: size.height * 0.04,
              ),

              //logo section
              // logo(size.height / 8, size.height / 8),
              SizedBox(
                height: size.height * 0.03,
              ),
              richText(24),
              SizedBox(
                height: size.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //email & password section
                      emailTextField(size),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      passwordTextField(size),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ]),
              ),

              //sign in button
              FloatingActionButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ApiProvider _api = new ApiProvider();
                      dynamic _loginData =
                          await _api.login(email.text, password.text);
                      final storage = new FlutterSecureStorage();
                      if (_loginData['data'] != null) {
                        dynamic data = _loginData['data'];
                        await storage.write(key: 'name', value: data['name']);
                        await storage.write(
                            key: 'id', value: data['id'].toString());
                        await storage.write(key: 'email', value: data['email']);
                        await storage.write(
                            key: 'api_token', value: data['api_token']);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Wrapper()),
                            );                      }else{
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "خطأ",
                          desc: "",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "متابعة",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                    }
                  },
                  child: signInButton(size)),
              SizedBox(
                height: size.height * 0.04,
              ),

              //footer section. sign up text here
              footerText(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget logo(double height_, double width_) {
  //   return SvgPicture.asset(
  //     'assets/logo.svg',
  //     height: height_,
  //     width: width_,
  //   );
  // }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: new TextStyle(fontFamily: 'cairo',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color:const Color(0xFF21899C),

        ),
        children: const [
          TextSpan(
            text: ' بيت',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: ' ',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'الحكمة ',
            style: TextStyle(
              color: Color(0xFFFE9879),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 11,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFEFEFEF),
        ),
      ),
      child: TextFormField(
        controller: email,
        validator: (value) {
          if (value!.isEmpty) {
            return 'اكتب بريد الكتروني صحيح';
          }
          return null;
        },
        style: new TextStyle(fontFamily: 'cairo',
          fontSize: 15.0,
          color:const Color(0xFF21899C),

        ),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
            labelText: 'البريد الألكتروني',
            labelStyle: new TextStyle(fontFamily: 'cairo',
              fontSize: 15.0,
              color:const Color(0xFF21899C),

            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 11,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFEFEFEF),
        ),
      ),
      child: TextFormField(
        controller: password,
        validator: (value) {
          if (value!.isEmpty) {
            return 'اكتب كلمة السر';
          }
          return null;
        },
        style: new TextStyle(fontFamily: 'cairo',
          fontSize: 15.0,
          color:const Color(0xFF21899C),

        ),
        maxLines: 1,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
            labelText: 'كلمةالسر',
            labelStyle: new TextStyle(fontFamily: 'cairo',
              fontSize: 15.0,
              color:const Color(0xFF21899C),

            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget signInButton(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 11,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: const Color(0xFF21899C),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C2E84).withOpacity(0.2),
            offset: const Offset(0, 15.0),
            blurRadius: 60.0,
          ),
        ],
      ),
      child: Text(
        'دخول',
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget footerText(context) {
    return GestureDetector(
        onTap: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
        child: Text.rich(
          TextSpan(
            style: new TextStyle(fontFamily: 'cairo',
              fontSize: 20.0,
              color:const Color(0xFF21899C),

            ),
            children: const [
              TextSpan(
                text: 'ليس لديك حساب ؟ ',
              ),
              TextSpan(
                text: ' ',
                style: TextStyle(
                  color: Color(0xFFFF5844),
                ),
              ),
              TextSpan(
                text: 'تسجيل جديد',
                style: TextStyle(
                  color: Color(0xFFFF5844),
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ));
  }
}
