import 'dart:convert';
import 'dart:ui';
import 'package:code/projectapp/models/login_patient.dart';
import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/models/staff.dart';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/pages/patient/patient_verify_otp_page.dart';
import 'package:code/projectapp/pages/start_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/login.dart';

class LoginPatientPage extends StatefulWidget {
  const LoginPatientPage({super.key});

  @override
  State<LoginPatientPage> createState() => _LoginPatientPage();
}

class _LoginPatientPage extends State<LoginPatientPage> {
  TextEditingController emailController = TextEditingController();

  Future<void> _loginPatient() async {
    try {
      final dio = Dio();
      final response = await dio.post(
        "http://10.0.2.2:3000/login_patient",
        data: {
          'email': emailController.text,
        },
      );

      final loginData = LoginPatient.fromJson(response.data);
      AuthPatient.currentUser = loginData.patient as Patient?;

      print('response.statusCode: ${response.statusCode}');
      print('response.data: ${response.data}');

      //fail
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
          msg: 'Server Error: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return;
      }

      if (loginData.status != 'success') {
        String errorMessage = loginData.message ?? 'Login failed';
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return;
      }
      // success
      Fluttertoast.showToast(
        msg: 'valid email',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PatientVerifyOtpPage(),
        ),
      );
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Login Patient',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(34, 135, 117, 1.0),
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _loginPatient,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.0),
                      backgroundColor: const Color.fromRGBO(34, 135, 117, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.0),
                      backgroundColor: Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
