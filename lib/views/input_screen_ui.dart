import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputScreenUI extends StatefulWidget {
  const InputScreenUI({super.key});

  @override
  State<InputScreenUI> createState() => _InputScreenUIState();
}

class _InputScreenUIState extends State<InputScreenUI> {
  //สร้างตัวแปรควบคุม TextField
  TextEditingController _carPriceCtrl = TextEditingController();
  TextEditingController _interestCtrl = TextEditingController();

  //สร้างตัวแปรควบคุม Radio
  int _downCtrl = 10;

  //สร้างตัวแปรควบคุม DropDown
  int _monthCtrl = 24;

  //สร้างตัวแปรเก็บรูปที่เลือกจากกล้องหรือแกลอรี่
  File? _imageFile;

  //สร้างเมธอดเปิดกล้อง
  _openCamera() async {
    final pickerImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickerImage == null) return;

    setState(() {
      _imageFile = File(pickerImage.path);
    });
  }

  //สร้างเมธอดเปิดแกลอรี่
  _openGallery() async {
    final pickerImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickerImage == null) return;

    setState(() {
      _imageFile = File(pickerImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'CI Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'คำนวณค่างวดรถ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      //เปิด Snackbar ให้ผู้ใช้เลือกเปิดกลอ้งหรือแกลอรี่
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  _openCamera();
                                },
                                title: Text(
                                  'เปิดกล้อง',
                                ),
                                leading: Icon(
                                  Icons.camera,
                                  color: Colors.yellow,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  _openGallery();
                                },
                                title: Text(
                                  'เปิดแกลอรี่',
                                ),
                                leading: Icon(
                                  Icons.image,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
                SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ราคารถ (บาท)',
                  ),
                ),
                TextField(
                  controller: _carPriceCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จำนวนเงินดาวน์ (%)',
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          _downCtrl = value!;
                        });
                      },
                      value: 10,
                      groupValue: _downCtrl,
                    ),
                    Text(
                      '10',
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          _downCtrl = value!;
                        });
                      },
                      value: 20,
                      groupValue: _downCtrl,
                    ),
                    Text(
                      '20',
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          _downCtrl = value!;
                        });
                      },
                      value: 30,
                      groupValue: _downCtrl,
                    ),
                    Text(
                      '30',
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          _downCtrl = value!;
                        });
                      },
                      value: 40,
                      groupValue: _downCtrl,
                    ),
                    Text(
                      '40',
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          _downCtrl = value!;
                        });
                      },
                      value: 50,
                      groupValue: _downCtrl,
                    ),
                    Text(
                      '50',
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          _downCtrl = value!;
                        });
                      },
                      value: 60,
                      groupValue: _downCtrl,
                    ),
                    Text(
                      '60',
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะเวลาผ่อน (เดือน)',
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: DropdownButton<int>(
                      value: _monthCtrl,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: (int? value) {
                        setState(() {
                          _monthCtrl = value!;
                        });
                      },
                      items: <int>[
                        24,
                        36,
                        48,
                        60,
                        72,
                      ].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            'ผ่อน $value เดือน',
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อัตราดอกเบี้ย (%/ปี)',
                  ),
                ),
                TextField(
                  controller: _interestCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'คำนวณ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    minimumSize: Size(
                      double.infinity,
                      55,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    minimumSize: Size(
                      double.infinity,
                      55,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
