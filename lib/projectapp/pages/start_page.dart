import 'package:code/projectapp/pages/login_page.dart';
import 'package:code/projectapp/pages/login_patient_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Image.asset('assets/images/logo.png'),
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          'Login Staff',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, (50.0)),
                            backgroundColor:
                                const Color.fromRGBO(62, 28, 168, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ))
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPatientPage()),
                          );
                        },
                        child: Text(
                          'Login Patient',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, (50.0)),
                            backgroundColor:
                                const Color.fromRGBO(34, 135, 117, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
