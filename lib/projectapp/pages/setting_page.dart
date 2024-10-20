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
            ElevatedButton(
              onPressed: _logout,
              child: const Text('LOGOUT', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,

              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor:Color.fromRGBO(62, 28, 168, 1.0),
                minimumSize: const Size(150.0, 50.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
