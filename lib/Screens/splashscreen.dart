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
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFB930),
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
            style: GoogleFonts.lato(
              fontSize: 50.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
