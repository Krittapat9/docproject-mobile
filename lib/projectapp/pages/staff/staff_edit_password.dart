import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';

class StaffEditPasswordPage extends StatefulWidget {
  StaffEditPasswordPage({super.key});

  @override
  State<StaffEditPasswordPage> createState() => _StaffEditPasswordPage();
}

class _StaffEditPasswordPage extends State<StaffEditPasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void clearForm() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> _editPassword() async {
    try {
      final dio = Dio();
      log("http://10.0.2.2:3000/staff/${Auth.currentUser?.id}/password");
      final response = await dio.put(
        "http://10.0.2.2:3000/staff/${Auth.currentUser?.id}/password",
        data: {
          'old_password': oldPasswordController.text,
          'new_password': newPasswordController.text,
        },
      );
      // log("${response.statusCode}");
      // log("${response.data}");
      if (response.statusCode == 200) {
        Auth.currentUser!.first_login = 1;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        // clearForm();
        // Navigator.of(context).pop();
      } else {
        // print('Error: ${response.data}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'invalid password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Edit Password',
                  style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(62, 28, 168, 1.0)),
                ),
              ),
              TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (newPasswordController.text ==
                          confirmPasswordController.text &&
                      oldPasswordController.text.isNotEmpty &&
                      newPasswordController.text.isNotEmpty) {
                    await _editPassword();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'edit fail',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(double.infinity, 50.0),
                    backgroundColor: Colors.yellow[700],
                    textStyle: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10,),
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
          ),
        ),
      ),
    );
  }
}
