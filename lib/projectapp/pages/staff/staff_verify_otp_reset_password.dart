import 'dart:ui';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class StaffVerifyOtpResetPasswordPage extends StatefulWidget {
  const StaffVerifyOtpResetPasswordPage({super.key});

  @override
  State<StaffVerifyOtpResetPasswordPage> createState() => _StaffVerifyOtpResetPasswordPage();
}

class _StaffVerifyOtpResetPasswordPage extends State<StaffVerifyOtpResetPasswordPage> {
  String otp = "";

  Future<void> _verifyOtp() async {
    try {
      final dio = Dio();
      final response = await dio.post(
        "http://10.0.2.2:3000/staff/fogetPassword/sendOTP",
        data: {
          'email': Auth.currentUser!.username,
          'otp': otp,
        },
      );
      final bool verify = response.data["verify"];
      if (verify) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(),
        //   ),
        // );
      } else {
        Fluttertoast.showToast(
          msg: 'Invalid OTP',
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

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(62, 28, 168, 1.0),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Color.fromRGBO(62, 28, 168, 1.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(62, 28, 168, 0.2),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Staff Verify OTP',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w900,
                  color: Color.fromRGBO(62, 28, 168, 1.0),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 4,
                onCompleted: (pin) {
                  otp = pin;
                  print("pin = $pin");
                },
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  _verifyOtp();
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(250, 55.0),
                  backgroundColor: const Color.fromRGBO(62, 28, 168, 1.0),
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
