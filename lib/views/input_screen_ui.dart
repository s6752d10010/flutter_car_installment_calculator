import 'package:flutter/material.dart';

class inputScreen extends StatefulWidget {
  const inputScreen({super.key});

  @override
  State<inputScreen> createState() => _inputState();
}

class _inputState extends State<inputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Car Installment Calculator',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
