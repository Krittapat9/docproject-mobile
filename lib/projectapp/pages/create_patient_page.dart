import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreatePatientPage extends StatefulWidget {
  CreatePatientPage({super.key});

  @override
  State<CreatePatientPage> createState() => _CreatePatientPage();
}

class _CreatePatientPage extends State<CreatePatientPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  void loadData() async {
    final dio = Dio();
    final response = await dio.post("http://10.0.2.2:3000/patient");
    print(response.data);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('ListApi2'),
      ),
      body: Column(
        children: [
          TextField(
            controller: usernameController,
          ),
          TextField(
            controller: firstnameController,
          ),
          TextField(
            controller: lastnameController,
          ),
          TextField(
            controller: passwordController,
          ),
          TextField(
            controller: pinController,
          ),
          ElevatedButton(
            onPressed: () async {
              print(usernameController.text);
              print(firstnameController.text);
              print(lastnameController.text);
              final dio = Dio();
              final response = await dio.post(
                "http://10.0.2.2:3000/staff",
                data: {
                  'username': usernameController.text,
                  'firstname': firstnameController.text,
                  'lastname': lastnameController.text,
                  'password': passwordController.text,
                  'pin': pinController.text,
                },
              );
            },
            child: Text('add data'),
          )
        ],
      ),
    );
  }

}