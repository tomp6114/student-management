import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management/widgets/constants.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    toHomeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
           Container(
             height: 200,
             width: 200,
             decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: kGreyColor),
              child: const Image(
                fit: BoxFit.cover,
                width: 200,
                height: 200,
                image: AssetImage("assets/splash-screens-19-twitchfeature.jpg"),
              ),
            ),
            kHeight30,
             Text("Student Management",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: const Color.fromARGB(255, 66, 61, 145),fontSize: 25),),
          ],
        ),
      ),
    );
  }

  Future<void> toHomeScreen() async{
    await Future.delayed(const Duration(seconds: 10),()
    {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }
}