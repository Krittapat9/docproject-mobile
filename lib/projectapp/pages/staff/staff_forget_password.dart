import 'dart:convert';
import 'dart:ui';
import 'package:code/projectapp/models/login.dart';
import 'package:code/projectapp/models/staff.dart';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/pages/staff/staff_verify_otp_reset_password.dart';
import 'package:code/projectapp/pages/start_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class StaffForgetPasswordPage extends StatefulWidget {
  const StaffForgetPasswordPage({super.key});

  @override
  State<StaffForgetPasswordPage> createState() => _StaffForgetPasswordPage();
}

class _StaffForgetPasswordPage extends State<StaffForgetPasswordPage> {
  TextEditingController usernameController = TextEditingController();


  Future<void> _StaffForgetPassword() async {
    try {
      final dio = Dio();
      final response = await dio.post(
        "http://10.0.2.2:3000/staff/fogetPassword/sendOTP",
        data: {
          'username': usernameController.text,
        },
      );

      final loginData = Login.fromJson(response.data);
      Auth.currentUser = loginData.staff as Staff?;

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
          builder: (context) => StaffVerifyOtpResetPasswordPage(),
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
                      'Forget Password',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(62, 28, 168, 1.0)),
                    ),
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        labelText: 'email',
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
                        onPressed: _StaffForgetPassword,
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0),
                          backgroundColor: const Color.fromRGBO(62, 28, 168, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
                            borderRadius: BorderRadius.circular(12),
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
