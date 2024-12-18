import 'package:code/projectapp/pages/staff/staff_edit_page.dart';
import 'package:code/projectapp/pages/staff/staff_edit_password.dart';
import 'package:code/projectapp/pages/start_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  void _logout() {
    Auth.currentUser = null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Setting',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (Auth.isStaff())
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StaffEditPasswordPage()));
              },
              child: const Text(
                'Edit password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(70.0, 55.0),
                backgroundColor: const Color.fromRGBO(62, 28, 168, 1.0),
                textStyle: TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // style: ElevatedButton.styleFrom(
              //   backgroundColor:Color.fromRGBO(62, 28, 168, 1.0),
              //   minimumSize: const Size(150.0, 50.0),
              // ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _logout,
              child: const Text(
                'logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(70.0, 55.0),
                backgroundColor: const Color.fromRGBO(62, 28, 168, 1.0),
                textStyle: TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // style: ElevatedButton.styleFrom(
              //   backgroundColor:Color.fromRGBO(62, 28, 168, 1.0),
              //   minimumSize: const Size(150.0, 50.0),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
