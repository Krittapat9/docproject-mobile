import 'dart:developer';
import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/models/surgery_type.dart';
import 'package:code/projectapp/models/disease.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SurgeryCreateModal extends StatefulWidget {
  final int patientId;

  SurgeryCreateModal({super.key, required this.patientId});

  @override
  State<SurgeryCreateModal> createState() => _SurgeryCreateModal();
}

class _SurgeryCreateModal extends State<SurgeryCreateModal> {
  TextEditingController diseaseNoteOtherController = TextEditingController();
  TextEditingController surgeryTypeNoteOtherController =
      TextEditingController();
  TextEditingController dateOfSurgeryController = TextEditingController();

  void clearForm() {
    diseaseNoteOtherController.text = '';
    surgeryTypeNoteOtherController.text = '';
    dateOfSurgeryController.text = '';
  }

  Future<void> _createSurgery() async {
    // print("http://10.0.2.2:3000/patient/${widget.patientId}/surgery");
    // print({
    //   'surgery_type_id': surgeryTypeId,
    //   'surgery_type_note_other': surgeryTypeNoteOtherController.text,
    //   'disease_id': diseaseId,
    //   'disease_note_other': diseaseNoteOtherController.text,
    //   'date_of_surgery': dateOfSurgeryController.text,
    //   'staff_id': Auth.currentUser?.id,
    // });
    final dio = Dio();
    final response = await dio.post(
      "http://10.0.2.2:3000/patient/${widget.patientId}/surgery",
      data: {
        'surgery_type_id': surgeryTypeId,
        'surgery_type_note_other': surgeryTypeNoteOtherController.text,
        'disease_id': diseaseId,
        'disease_note_other': diseaseNoteOtherController.text,
        'date_of_surgery': DateTime.now().toIso8601String(),
        'staff_id': Auth.currentUser?.id,
      },
    );
    if (response.statusCode == 200) {
      print('Surgery created successfully!');
      clearForm();
      Navigator.of(context).pop();
      setState(() async {
        await loadDataSurgery();
      });
    } else {
      print('Error creating patient: ${response.data}');
    }
  }

//get disease
  List<Disease> diseaseList = [];
  int diseaseId = 0;
//get Surgery type
  List<SurgeryType> surgeryTypeList = [];
  int surgeryTypeId = 0;

  Future<bool> loadDataSurgery() async {
    try {
      //get disease
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/disease");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        diseaseList = jsonList.map((json) => Disease.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
      // throw Exception('Error fetching disease: $error');
    }
    //get surgery type
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/surgery/type");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        surgeryTypeList =
            jsonList.map((json) => SurgeryType.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
      // throw Exception('Error fetching surgery type: $error');
    }
    // await Future.delayed(Duration(seconds: 1));

    return true;
  }

  //get surgery

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadDataSurgery(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return AlertDialog(
              // title: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('เพิ่มการวินิจฉัย และ การผ่าตัด',
              //         style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
              //     IconButton(
              //       icon: Icon(Icons.close),
              //       onPressed: () {
              //         // ฟังก์ชันสำหรับปิด
              //         Navigator.pop(context); /
              //       },
              //     ),
              //   ],
              // ),
              title: Center(
                child: Text('เพิ่มการวินิจฉัย และ การผ่าตัด',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: 10),
              contentPadding: EdgeInsets.zero,
              titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
              content: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Diagnosis\n(การวินิจฉัย)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                        DropdownButton(
                          value: diseaseId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            ...diseaseList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('disease:$val');
                            setState(() {
                              diseaseId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 400,
                      child: TextField(
                        controller: diseaseNoteOtherController,
                        decoration: InputDecoration(
                          labelText: 'Other',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Surgery type\n(ประเภทการผ่าตัด)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        DropdownButton(
                          value: surgeryTypeId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text('Please Select',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                            ),
                            ...surgeryTypeList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('surgery type:$val');
                            setState(() {
                              surgeryTypeId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 400,
                      child: TextField(
                        controller: surgeryTypeNoteOtherController,
                        decoration: InputDecoration(
                          labelText: 'Other',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        await _createSurgery();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0),
                          backgroundColor:
                              const Color.fromRGBO(62, 28, 168, 1.0),
                          textStyle: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0),
                          backgroundColor: Colors.redAccent,
                          textStyle: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
