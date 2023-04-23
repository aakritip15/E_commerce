import 'package:app_1/Screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';
import '/consts/consts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(appIcon)),
          SizedBox(
            height: 30.0,
            width: double.infinity,
          ),
          Text(
            'Resell-It',
            style: GoogleFonts.nunito(
              fontSize: 50.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFB930),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
