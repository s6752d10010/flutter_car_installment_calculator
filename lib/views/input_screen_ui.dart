import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seven_page_app/views/result_screen_ui.dart';
//import 'package:flutter_car_installment_calculator/views/result_screen_ui.dart'; // ใช้อันเดียวพอ

class InputScreenUI extends StatefulWidget {
  const InputScreenUI({super.key});

  @override
  State<InputScreenUI> createState() => _InputScreenUIState();
}

class _InputScreenUIState extends State<InputScreenUI> {
  TextEditingController _carPriceCtrl = TextEditingController();
  TextEditingController _interestCtrl = TextEditingController();

  int _downCtrl = 10;
  int _monthCtrl = 24;
  File? _imageFile;

  @override
  void dispose() {
    _carPriceCtrl.dispose();
    _interestCtrl.dispose();
    super.dispose();
  }

  _warningDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('คำเตือน'),
        content: Text(msg),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  _openCamera() async {
    final pickerImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickerImage == null) return;
    setState(() => _imageFile = File(pickerImage.path));
  }

  _openGallery() async {
    final pickerImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerImage == null) return;
    setState(() => _imageFile = File(pickerImage.path));
  }

  _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('เปิดกล้อง'),
            onTap: () {
              Navigator.pop(context);
              _openCamera();
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('เปิดแกลอรี่'),
            onTap: () {
              Navigator.pop(context);
              _openGallery();
            },
          ),
        ],
      ),
    );
  }

  _clearAllInputs() {
    setState(() {
      _carPriceCtrl.clear();
      _interestCtrl.clear();
      _downCtrl = 10;
      _monthCtrl = 24;
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('CI Calculator', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Text('คำนวณค่างวดรถ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: InkWell(
                onTap: _showImagePickerOptions,
                child: _imageFile == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/img02.png',
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _imageFile!,
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 30.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('ราคารถ (บาท)'),
            ),
            TextField(
              controller: _carPriceCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '0.00',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 15.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('จำนวนเงินดาวน์ (%)'),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [10, 20, 30, 40, 50, 60].map((value) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<int>(
                      value: value,
                      groupValue: _downCtrl,
                      onChanged: (val) => setState(() => _downCtrl = val!),
                    ),
                    Text('$value'),
                  ],
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('ระยะเวลาผ่อน (เดือน)'),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton<int>(
                  value: _monthCtrl,
                  isExpanded: true,
                  underline: Container(),
                  onChanged: (int? val) => setState(() => _monthCtrl = val!),
                  items: [24, 36, 48, 60, 72].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('ผ่อน $value เดือน'),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('อัตราดอกเบี้ย (%/ปี)'),
            ),
            TextField(
              controller: _interestCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '0.00',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                if (_carPriceCtrl.text.isEmpty) {
                  _warningDialog('ป้อนราคารถด้วย..!!!');
                } else if (_interestCtrl.text.isEmpty) {
                  _warningDialog('ป้อนอัตราดอกเบี้ยด้วย..!!!');
                } else {
                  double carPrice = double.parse(_carPriceCtrl.text);
                  double interest = double.parse(_interestCtrl.text);
                  double balance = carPrice - (carPrice * _downCtrl / 100);
                  double totalInterest =
                      (balance * interest / 100 / 12) * _monthCtrl;
                  double payPerMonth = (balance + totalInterest) / _monthCtrl;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreenUI(
                        carPrice: carPrice,
                        payPerMonth: payPerMonth,
                        month: _monthCtrl,
                      ),
                    ),
                  );
                }
              },
              child: Text('คำนวณ', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                minimumSize: Size(double.infinity, 55),
              ),
            ),
            SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: _clearAllInputs,
              child: Text('ยกเลิก', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                minimumSize: Size(double.infinity, 55),
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
