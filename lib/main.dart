import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seven_page_app/views/input_screen_ui.dart';

void main() {
  runApp(FlutterCarInstallmentCalculatorApp());
}

class FlutterCarInstallmentCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Installment Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.kanitTextTheme(),
      ),
      home: InputScreenUI(),
    );
  }
}
