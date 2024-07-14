import 'package:code/projectapp/models/patient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPage();
}

class _PatientListPage extends State<PatientListPage> {
  final List<Patient> patients = [];


  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData()async{
    final dio=Dio();
    final response=await dio.get('http://10.0.2.2:3000/patient');
    print(response.data['results']);
    for(var item in response.data['results']){
      item.add(Patient.fromJson(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientListPage'),
      ),
      body: Column(
        children: [
          patients.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    final patient = patients[index];
                    return ListTile(
                      title: Text(patient.firstname),
                      subtitle: Text(
                          'ID:${patient.id},'
                              'firstname:${patient.firstname},'
                              'lastname:${patient.lastname},'
                              'sex:${patient.sex},'
                              'DOB:${patient.date_of_birth},'
                              'HN${patient.hospital_number},'
                              'doctor${patient.staff_id},'
                              'DOR${patient.date_of_registration}'
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
