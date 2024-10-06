import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class PatientEditPage extends StatefulWidget {
  final int patientId;
  PatientEditPage({super.key, required this.patientId});

  @override
  State<PatientEditPage> createState() => _PatientEditPage();
}

class _PatientEditPage extends State<PatientEditPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController hospitalNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void clearForm() {
    firstnameController.text = '';
    lastnameController.text = '';
    sexController.text = '';
    dateOfBirthController.text = '';
    hospitalNumberController.text = '';
    emailController.text = '';
  }
  Patient? patient;
  Future<Patient> getPatientInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/patient/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      patient = Patient.fromJson(response.data);
      return patient!;
    } else {
      throw Exception(
          'Failed to load patients (status code: ${response.statusCode})');
    }
  }

  Future<void> _editPatient() async {
    final dio = Dio();
    final response = await dio.put(
      "http://10.0.2.2:3000/patient/${patient!.id}",
      data: {
        'staff_id': Auth.currentUser?.id,
        'firstname': firstnameController.text,
        'lastname': lastnameController.text,
        'sex': sexController.text,
        'date_of_birth': dateOfBirthController.text,
        'hospital_number': hospitalNumberController.text,
        'email' : emailController.text
      },
    );
    if (response.statusCode == 200) {
      // Patient patient = Patient.fromJson(response.data);
      //
      // print('Patient created successfully!');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Patient created successfully!'),
      // ));
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
      await getPatientInfo(widget.patientId);
      firstnameController.text = patient!.firstname;
      lastnameController.text = patient!.lastname;
      sexController.text = patient!.sex;
      dateOfBirthController.text = patient!.date_of_birth.toIso8601String();
      hospitalNumberController.text = patient!.hospital_number;
      emailController.text = patient!.email ?? '';
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
          'Add Patient',
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
              controller: firstnameController,
              decoration: InputDecoration(
                labelText: 'firstname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: lastnameController,
              decoration: InputDecoration(
                labelText: 'lastname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: sexController,
              decoration: InputDecoration(
                labelText: 'sex',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: dateOfBirthController,
              decoration: InputDecoration(
                labelText: 'date of birth',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: hospitalNumberController,
              decoration: InputDecoration(
                labelText: 'hospital number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'email',
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
                  textStyle: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
