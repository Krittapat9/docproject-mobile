import 'dart:io';

import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class PatientCreatePage extends StatefulWidget {
  PatientCreatePage({super.key});

  @override
  State<PatientCreatePage> createState() => _PatientCreatePage();
}

class _PatientCreatePage extends State<PatientCreatePage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController hospitalNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? selectedSex;

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;

  void clearForm() {
    firstnameController.clear();
    lastnameController.clear();
    sexController.clear();
    dateOfBirthController.clear();
    hospitalNumberController.clear();
    emailController.clear();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _createPatient() async {
    final dio = Dio();
    String email = emailController.text;

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid email format.'),
      ));
      return; // ถ้า email format ไม่ถูกต้อง หยุดการทำงาน
    }

    try {
      FormData formData = FormData.fromMap({
        'staff_id': Auth.currentUser?.id,
        'firstname': firstnameController.text,
        'lastname': lastnameController.text,
        'sex': sexController.text,
        'date_of_birth': dateOfBirthController.text,
        'hospital_number': hospitalNumberController.text,
        'date_of_registration': DateTime.now().toIso8601String(),
        'email': emailController.text,
        'image': await MultipartFile.fromFile(pickedFile!.path,
            filename: path.basename(pickedFile!.path)),
      });

      final response = await dio.post(
        "http://10.0.2.2:3000/patient",
        data: formData,
      );
      if (response.statusCode == 200) {
        Patient patient = Patient.fromJson(response.data);
        print('Patient created successfully!');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Patient created successfully!'),
        ));
        clearForm();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PatientInfoPage(patientId: patient.id),
          ),
        );
      } else {
        _handleErrorResponse(response);
        print('Error creating patient: ${response.data}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('fail'),
      ));
      print('Exception: $e');
    }
  }

  void _handleErrorResponse(Response response) {
    if (response.data is Map<String, dynamic>) {
      String errorMessage =
          response.data['error'] ?? 'An unknown error occurred.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An unknown error occurred.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Create Patient',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Color set here
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Create Patient',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 90,
                  );
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: Colors.black),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('image'), Icon(Icons.add)],
                )),
            pickedFile != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      File(pickedFile!.path),
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(
                    width: 100, // กำหนดขนาดที่ต้องการแม้ยังไม่มีรูป
                    height: 100,
                    child: Icon(Icons.image, size: 70, color: Colors.grey),
                  ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: firstnameController,
              decoration: InputDecoration(
                labelText: 'firstname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: lastnameController,
              decoration: InputDecoration(
                labelText: 'lastname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            // TextField(
            //   controller: sexController,
            //   decoration: InputDecoration(
            //     labelText: 'sex',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //   ),
            // ),
            DropdownButtonFormField<String>(
              value: selectedSex,
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    'Please select',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Male',
                  child: Text('Male'),
                ),
                DropdownMenuItem<String>(
                  value: 'Female',
                  child: Text('Female'),
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  selectedSex = newValue;
                  sexController.text = newValue ?? ''; // กำหนดค่าให้ controller
                });
              },
              decoration: InputDecoration(
                labelText: 'sex',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateOfBirthController,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      //icon of text field
                      labelText: "Enter Date of Birth", //label text of field
                    ),
                    readOnly: true,
                    // when true user cannot edit text
                    onTap: () async {
                      final d = DateTime.now();

                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: d,
                        //get today's date
                        firstDate: DateTime(1900),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: d,
                      );

                      if (pickedDate != null) {
                        print(
                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        print(
                            formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                        setState(() {
                          dateOfBirthController.text =
                              formattedDate; //set foratted date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: hospitalNumberController,
              decoration: InputDecoration(
                labelText: 'hospital number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                await _createPatient();
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50.0),
                  backgroundColor: const Color.fromRGBO(62, 28, 168, 1.0),
                  textStyle: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
