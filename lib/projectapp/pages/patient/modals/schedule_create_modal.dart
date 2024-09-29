import 'dart:developer';
import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/models/stoma_type.dart';
import 'package:code/projectapp/models/surgery.dart';
import 'package:code/projectapp/models/surgery_type.dart';
import 'package:code/projectapp/models/disease.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ScheduleCreateModal extends StatefulWidget {
  final int patientId;

  ScheduleCreateModal({super.key, required this.patientId});

  @override
  State<ScheduleCreateModal> createState() => _ScheduleCreateModal();
}

class _ScheduleCreateModal extends State<ScheduleCreateModal> {
  TextEditingController workDateController = TextEditingController();

  void clearForm() {
    workDateController.clear();
  }

  Future<void> _createStoma() async {
    final dio = Dio();
    final response = await dio.post(
      "http://10.0.2.2:3000/stoma",
      data: {
        'stoma_type_id': stomaTypeId,
      },
    );
    if (response.statusCode == 200) {
      print('Surgery created successfully!');
      clearForm();
      Navigator.of(context).pop();
      // setState(() async {
      //
      // });
    } else {
      print('Error creating patient: ${response.data}');
    }
  }

  List<StomaType> stomaTypeList = [];
  int stomaTypeId = 0;

  Future<bool> loadData() async {
    //get surgery type
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/stoma/type");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        stomaTypeList =
            jsonList.map((json) => StomaType.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
      // throw Exception('Error fetching surgery type: $error');
    }
    await Future.delayed(Duration(seconds: 1));

    return true;
  }

  //get surgery

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
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
                child: Text('เพิ่มประเภท Stoma',
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
                        Expanded(
                          child: TextField(
                            controller: workDateController,
                            //editing controller of this TextField
                            decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              //icon of text field
                              labelText: "Enter Date", //label text of field
                            ),
                            readOnly: true,
                            // when true user cannot edit text
                            onTap: () async {
                              final d = DateTime.now();

                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: d.add(const Duration(days: 1)),
                                //get today's date
                                firstDate: DateTime.now(),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: d.add(const Duration(days: 30 * 3)),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _createStoma();
                        // setState(() {
                        //
                        // });
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
