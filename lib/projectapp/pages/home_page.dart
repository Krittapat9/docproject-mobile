import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _Homepage();
}

class _Homepage extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: const Center(
        child: Text('Welcome to the Homepage!'),
      ),
    );
  }
}
