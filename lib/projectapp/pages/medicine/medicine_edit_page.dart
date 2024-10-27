import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/models/medicine.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class MedicineEditPage extends StatefulWidget {
  final int medicineId;
  MedicineEditPage({super.key, required this.medicineId});

  @override
  State<MedicineEditPage> createState() => _MedicineEditPage();
}

class _MedicineEditPage extends State<MedicineEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  void clearForm() {
    nameController.text = '';
    detailsController.text = '';
  }
  Medicine? medicine;
  Future<Medicine> getMedicineInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/medicine/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      medicine = Medicine.fromJson(response.data);
      return medicine!;
    } else {
      throw Exception(
          'Failed to load patients (status code: ${response.statusCode})');
    }
  }

  Future<void> _editPatient() async {
    final dio = Dio();
    final response = await dio.put(
      "http://10.0.2.2:3000/medicine/${medicine!.id}",
      data: {
        'name': nameController.text,
        'detail': detailsController.text,
      },
    );
    if (response.statusCode == 200) {
      clearForm();
      Navigator.of(context).pop();
    } else {
      print('Error edit medicine: ${response.data}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,() async{
      await getMedicineInfo(widget.medicineId);
      nameController.text = medicine!.name;
      detailsController.text = medicine!.details;
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
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'name medicine',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(
                labelText: 'detail',
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
