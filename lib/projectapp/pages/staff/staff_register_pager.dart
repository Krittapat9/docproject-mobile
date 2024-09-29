import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StaffRegisterPage extends StatefulWidget {
  StaffRegisterPage({super.key});

  @override
  State<StaffRegisterPage> createState() => _StaffRegisterPage();
}

class _StaffRegisterPage extends State<StaffRegisterPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void clearForm() {
    firstnameController.text = '';
    lastnameController.text = '';
    usernameController.text = '';
    passwordController.text = '';
  }

  Future<void> _createPatient() async {
    final dio = Dio();
    final response = await dio.post(
      "http://10.0.2.2:3000/staff",
      data: {
        'firstname': firstnameController.text,
        'lastname': lastnameController.text,
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );
    if (response.statusCode == 200) {
      print('Patient created successfully!');
      clearForm();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      print('Error creating staff: ${response.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Register Staff',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'password',
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
                'Register',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              style: ElevatedButton.styleFrom(
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
