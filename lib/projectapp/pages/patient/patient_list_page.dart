import 'dart:developer';

import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/pages/patient/patient_create_page.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPage();
}

class _PatientListPage extends State<PatientListPage> {
  @override

  List<Patient> patientList = [];

  Future<List<Patient>> getPatientList() async {
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/patient");

      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        patientList = jsonList.map((json) => Patient.fromJson(json)).toList();
        return patientList;
      } else {
        // throw Exception(
        //     'Failed to load patients (status code: ${response.statusCode})');
      }
    } catch (error) {
      log('err:$error');
      // throw Exception('Error fetching patients: $error');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Patient List',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientCreatePage()));
              },
              child: Image.asset(
                'assets/images/add-user-white.png',
                width: 38.0,
                height: 38.0,
              ))
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Color set here
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Patient>>(
        future: getPatientList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No patients found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final patient = snapshot.data![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PatientInfoPage(patientId: patient.id,),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  margin: EdgeInsets.all(4.0),
                  child: ListTile(
                    title: Text(
                      '${patient.firstname} ${patient.lastname}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.0,
                    ),
                    // subtitle: Text('ID: ${patient.id}'
                    //     'firstname:${patient.firstname},'
                    //     'lastname:${patient.lastname},'
                    //     'sex:${patient.sex},'
                    //     'DOB:${patient.date_of_birth},'
                    //     'HN:${patient.hospital_number},'
                    //     'doctor:${patient.staff_id},'
                    //     'DOR:${patient.date_of_registration}'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
