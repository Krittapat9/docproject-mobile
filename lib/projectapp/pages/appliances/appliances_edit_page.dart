import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AppliancesEditPage extends StatefulWidget {
  final int appliancesId;
  AppliancesEditPage({super.key, required this.appliancesId});

  @override
  State<AppliancesEditPage> createState() => _AppliancesEditPage();
}

class _AppliancesEditPage extends State<AppliancesEditPage> {
  TextEditingController typeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController nameFlangeController = TextEditingController();
  TextEditingController namePouchController = TextEditingController();
  TextEditingController sizeController = TextEditingController();

  void clearForm() {
    typeController.text = '';
    nameController.text = '';
    brandController.text = '';
    nameFlangeController.text = '';
    namePouchController.text = '';
    sizeController.text = '';
  }
  Appliances? appliances;
  Future<Appliances> getAppliancesInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/appliances/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      appliances = Appliances.fromJson(response.data);
      return appliances!;
    } else {
      throw Exception(
          'Failed to load patients (status code: ${response.statusCode})');
    }
  }

  Future<void> _editPatient() async {
    final dio = Dio();
    final response = await dio.put(
      "http://10.0.2.2:3000/patient/${appliances!.id}",
      data: {
        'type': typeController.text,
        'name': nameController.text,
        'brand': brandController.text,
        'name_flange': nameFlangeController.text,
        'name_pouch': namePouchController.text,
        'size': sizeController.text,
      },
    );
    if (response.statusCode == 200) {
      clearForm();
      Navigator.of(context).pop();
    } else {
      print('Error creating patient: ${response.data}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,() async{
      await getAppliancesInfo(widget.appliancesId);
      typeController.text = appliances!.type;
      nameController.text = appliances!.name;
      brandController.text = appliances!.brand;
      nameFlangeController.text = appliances!.name_flange;
      namePouchController.text = appliances!.name_pouch;
      sizeController.text = appliances!.size;
      setState(() {

      });
    } );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Edit Appliance',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                labelText: 'type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'name appliance set',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: brandController,
              decoration: InputDecoration(
                labelText: 'brand',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: nameFlangeController,
              decoration: InputDecoration(
                labelText: 'name flange',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: namePouchController,
              decoration: InputDecoration(
                labelText: 'name pouch',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: sizeController,
              decoration: InputDecoration(
                labelText: 'size',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                await _editPatient();
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
                  backgroundColor: Colors.yellow,
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
