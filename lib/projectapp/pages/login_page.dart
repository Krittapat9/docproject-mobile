import 'dart:convert';
import 'dart:ui';
import 'package:code/projectapp/models/staff_name.dart';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {


  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> _login() async {
    try {
      final dio = Dio();
      final response = await dio.post(
        "http://10.0.2.2:3000/login",
        data: {
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          Fluttertoast.showToast(
            msg: 'เข้าสู่ระบบสำเร็จ',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          String errorMessage = responseData['message'] ?? 'Login failed';
          Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Server Error: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
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
      child: SingleChildScrollView(
        padding:EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Text(
                'LOGIN',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.0),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
