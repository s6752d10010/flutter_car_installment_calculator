import 'package:flutter/material.dart';
import 'input_screen_ui.dart'; // อย่าลืม import หน้านี้

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => inputScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img01.png',
              width: 230.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Car Installment',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),
            Text(
              'Calculator',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),
            SizedBox(height: 30.0),
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 30.0),
            Text(
              'Created by NinniN DTI-SAU',
              style: TextStyle(fontSize: 14.0, color: Colors.lightGreenAccent),
            ),
            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 15.0, color: Colors.lightGreenAccent),
            ),
          ],
        ),
      ),
    );
  }
}
