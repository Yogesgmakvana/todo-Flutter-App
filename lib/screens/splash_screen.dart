import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void>loadSplashScreen()async{
    await Future.delayed(Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSplashScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: LottieBuilder.asset('assets/lottie/Checklist.json',height: 470,width: 470,)),
          ],
        ),
      ),
    );
  }
}