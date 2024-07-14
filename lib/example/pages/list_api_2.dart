import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListApi2Page extends StatefulWidget {
  ListApi2Page({super.key});

  @override
  State<ListApi2Page> createState() => _ListApi2Page();
}

class _ListApi2Page extends State<ListApi2Page> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

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

  void loadData() async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/staff");
    print(response.data);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }
}
