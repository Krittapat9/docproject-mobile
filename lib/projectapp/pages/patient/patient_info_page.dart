import 'dart:convert';
import 'dart:developer';
import 'package:code/projectapp/models/surgery.dart';
import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:code/projectapp/pages/medical_history/medical_history_list_page.dart';
import 'package:code/projectapp/pages/patient/modals/schedule_create_modal.dart';
import 'package:code/projectapp/pages/patient/modals/stoma_create_modal.dart';
import 'package:code/projectapp/pages/patient/modals/surgery_create_modal.dart';
import 'package:code/projectapp/pages/patient/patient_edit_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/patient.dart';

class PatientInfoPage extends StatefulWidget {
  final int patientId;

  const PatientInfoPage({
    super.key,
    required this.patientId,
  });

  @override
  State<PatientInfoPage> createState() => _PatientInfoPage();
}

class _PatientInfoPage extends State<PatientInfoPage> {
  Patient? patient;

  List<Surgery> surgeryList = [];

  Future<Patient> getPatientInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/patient/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      patient = Patient.fromJson(response.data);
      await loadSurgery(id);
      return patient!;
    } else {
      throw Exception(
          'Failed to load patients (status code: ${response.statusCode})');
    }
  }

  Future<bool> loadSurgery(int patientId) async {
    try {
      final dio = Dio();
      final response =
          await dio.get("http://10.0.2.2:3000/patient/$patientId/surgery");

      log('data:${response.data}');
      log('response.statusCode=${response.statusCode}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        log('surgery');
        log(jsonList.length.toString());
        try {
          surgeryList = jsonList.map((json) => Surgery.fromJson(json)).toList();
          log('----------------------------------------------');
          log(surgeryList.toString());
        } catch (e) {
          log(e.toString());
        }
      } else {
        throw Exception(
            'Failed to load patients (status code: ${response.statusCode})');
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return true;
  }

  Future<bool> deleteSurgery(int surgeryId) async {
    try {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Delete Surgery',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.redAccent,
            ),
          ),
          content: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(child: Text('Are you sure to delete this surgery?')),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final dio = Dio();
                final response = await dio
                    .delete("http://10.0.2.2:3000/surgery/${surgeryId}");

                log('data:${response.data}');
                log('response.statusCode=${response.statusCode}');
                if (response.statusCode == 200) {
                } else {
                  throw Exception(
                      'Failed to load patients (status code: ${response.statusCode})');
                }
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
              child: new Text(
                'OK',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text(
                'cancel',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Widget _InfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Text('$label : ',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _InfoSurgery(Surgery surgeryInfo) {
    return InkWell(
      onTap: surgeryInfo.stoma_id != null && surgeryInfo.stoma_id! > 0
          ? () async => await Navigator.push(
                (context),
                MaterialPageRoute(
                  builder: (context) =>
                      MedicalHistoryListPage(surgeryId: surgeryInfo.id),
                ),
              )
          : null,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          // Adjust the radius as needed
          side: BorderSide(
            color: surgeryInfo.stoma_id != null && surgeryInfo.stoma_id! > 0
                ? Colors.black
                : Colors.green,
            width: 1.5, // Border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Case ID : ',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '${surgeryInfo.case_id}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      if (Auth.isStaff())
                      IconButton(
                          onPressed: () async {
                            await deleteSurgery(surgeryInfo!.id)
                                .then((onValue) {
                              setState(() {});
                            });
                          },
                          icon: Icon(Icons.delete_forever)),
                    ],
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Disease (โรค) : ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${surgeryInfo.disease_name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Diseae note : ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${surgeryInfo.disease_note_other ?? '-'}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Surgery type (ปรเภทการผ่าตัด) : ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${surgeryInfo.surgery_type_name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Surgery type note : ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${surgeryInfo.surgery_type_note_other ?? '-'}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'วัน/เดือน/ปี ที่ผ่าตัด : ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: DateFormat('dd / MMM / yyyy')
                              .format(surgeryInfo?.date_of_surgery?? DateTime.now()),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'แพทย์ผู้ผ่าตัด : ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              '${surgeryInfo.staff_firstname} ${surgeryInfo.staff_lastname}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  surgeryInfo.stoma_id != null && surgeryInfo.stoma_id! > 0
                      ? Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text:
                                  'ประเภทของ Stoma : ${surgeryInfo.stoma_type_name}\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  'Stoma note : ${surgeryInfo.stoma_type_note_other}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return StomaCreateModal(
                                    surgery: surgeryInfo,
                                  );
                                });
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.black),
                          ),
                          child: SizedBox(
                            width: 150,
                            child: Row(
                              children: [
                                Text(
                                  'เพิ่มประเภท Stoma',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Color.fromRGBO(62, 28, 162, 1.0),
                                )
                              ],
                            ),
                          ),
                        ),
                  SizedBox(height: 15),
                ],
              ),
              surgeryInfo.stoma_id != null && surgeryInfo.stoma_id! > 0
                  ? Icon(Icons.arrow_forward_ios)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Patient Information',
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
          automaticallyImplyLeading: false,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ]),
      drawer: Drawer(
        child: Text('hello'),
      ),

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPatientInfo(widget.patientId),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 5),
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('ข้อมูลผู้ป่วย',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Spacer(),
                                  if (Auth.isStaff())
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PatientEditPage(
                                                    patientId: patient!.id),
                                          ),
                                        ).then((val) {
                                          setState(() {
                                            print('return 2');
                                          });
                                        });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 25,
                                      ))
                                ],
                              ),
                              Divider(),
                              _InfoRow('ชื่อ-นามสกุล',
                                  '${patient?.firstname} ${patient?.lastname}'),
                              _InfoRow('เพศ', '${patient?.sex}'),
                              _InfoRow(
                                  'วันเดือนปีเกิด',
                                  DateFormat('dd / MMM / yyyy').format(
                                      patient?.date_of_birth ??
                                          DateTime.now())),
                              _InfoRow('หมายเลขโรงพยาบาล',
                                  '${patient?.hospital_number}'),
                              _InfoRow(
                                  'email', patient?.email?.toString() ?? '-'),
                              _InfoRow('ผู้ลงทะเบียน',
                                  '${patient?.staff_firstname} ${patient?.staff_lastname}'),
                              _InfoRow(
                                  'วันเวลาลงทะเบียน',
                                  DateFormat('dd / MMM / yyyy-H:MM:ss').format(
                                      patient?.date_of_registration ??
                                          DateTime.now())),
                            ],
                          ),
                        ),
                        if (Auth.isStaff())
                        SizedBox(
                          height: 13.0,
                        ),
                        if (Auth.isStaff())
                        Container(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return SurgeryCreateModal(
                                      patientId: widget.patientId,
                                    );
                                  }).then((val) {
                                setState(() {
                                  print('return 2');
                                });
                              });
                              setState(() {
                                print('return 1');
                              });

                              // showBottomSheet(context: context,
                              //     builder: (BuildContext context){
                              //       return SurgeryCreatePage();
                              //     }
                              // );

                              // Navigator.pushReplacement(
                              //     (context),
                              //     MaterialPageRoute(
                              //         builder: (context) => SurgeryCreatePage()));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: Colors.black),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'เพิ่มการวินิจฉัย และ การผ่าตัด',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.add,
                                  size: 36,
                                  color: Color.fromRGBO(62, 28, 162, 1.0),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (Auth.isStaff())
                        SizedBox(
                          height: 8,
                        ),
                        if (Auth.isStaff())
                        Container(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return ScheduleCreateModal(
                                        patientId: widget.patientId,
                                      );
                                    }).then((val) {
                                  setState(() {
                                    print('return 2');
                                  });
                                });
                                setState(() {
                                  print('return 1');
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(color: Colors.black),
                              ),
                              child: Text(
                                'นัดหมาย',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          height: 13.0,
                        ),
                        Center(
                          child: Text('ข้อมูลการวินิจฉัยโรคและการผ่าตัด',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (surgeryList.isEmpty)
                              Center(
                                child: Text(
                                    'The diagnosis and surgery were not recorded'),
                              )
                            else
                              ...surgeryList
                                  .map((surgery) => _InfoSurgery(
                                        surgery,
                                      ))
                                  .toList(),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            width: double.maxFinite,
            height: 50,
            color: Colors.grey,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
