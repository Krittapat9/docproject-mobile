import 'package:code/projectapp/models/staff.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class StaffEditPage extends StatefulWidget {
  final int staffId;

  StaffEditPage({super.key, required this.staffId});

  @override
  State<StaffEditPage> createState() => _StaffEditPage();
}

class _StaffEditPage extends State<StaffEditPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  void clearForm() {
    firstnameController.clear();
    lastnameController.clear();
    usernameController.clear();
  }

  Staff? staff;

  Future<Staff> getStaffInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/staff/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      staff = Staff.fromJson(response.data);
      return staff!;
    } else {
      throw Exception(
          'Failed to load staff (status code: ${response.statusCode})');
    }
  }

  Future<void> _editStaff() async {
    final dio = Dio();
    final response = await dio.put(
      "http://10.0.2.2:3000/staff/${staff!.id}",
      data: {
        'firstname': firstnameController.text,
        'lastname': lastnameController.text,
        'user': usernameController.text,
      },
    );
    if (response.statusCode == 200) {
      clearForm();
      Navigator.of(context).pop();
    } else {
      print('Error creating staff: ${response.data}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getStaffInfo(widget.staffId);
      firstnameController.text = staff!.firstname;
      lastnameController.text = staff!.lastname;
      usernameController.text = staff!.username;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Edit Staff',
          style: TextStyle(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: firstnameController,
              decoration: InputDecoration(
                labelText: 'firstname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                  labelText: 'lastname',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                // maxLines: 3,
              ),
            ),
            SizedBox(
              height: 55.0,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'username',
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
                await _editStaff();
              },
              child: Text(
                'Edit',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                  backgroundColor: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
