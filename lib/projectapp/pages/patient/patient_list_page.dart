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
  String searchBox = '';

  Future<List<Patient>> getPatientList([String query = '']) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "http://10.0.2.2:3000/patient",
        queryParameters: {'q': query},
      );

      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        return jsonList.map((json) => Patient.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load patients (status code: ${response.statusCode})');
      }
    } catch (error) {
      log('err:$error');
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
                            builder: (context) => PatientCreatePage()))
                    .then((onValue) {
                  setState(() {});
                });
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchBox = value;
                });
                getPatientList(searchBox);
              },
              decoration: InputDecoration(
                labelText: 'Search name or email',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<List<Patient>>(
              future: getPatientList(searchBox),
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
                            builder: (context) => PatientInfoPage(
                              patientId: patient.id,
                            ),
                          ),
                        ).then((onValue) {
                          setState(() {
                            print('return 2');
                          });
                        });
                      },
                      child: Card(
                        elevation: 4,
                        color: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        margin: EdgeInsets.all(4.0),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(
                              '${patient.firstname} ${patient.lastname}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 24.0,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text('email : ${patient.email}',style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
