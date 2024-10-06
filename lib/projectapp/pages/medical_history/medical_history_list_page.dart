import 'dart:developer';
import 'package:code/projectapp/models/medical_history.dart';
import 'package:code/projectapp/models/surgery.dart';
import 'package:code/projectapp/models/surgery_medical_history.dart';
import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:code/projectapp/pages/medical_history/medical_history_create_page.dart';
import 'package:code/projectapp/pages/medical_history/medical_history_info_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MedicalHistoryListPage extends StatefulWidget {
  final int surgeryId;

  const MedicalHistoryListPage({super.key, required this.surgeryId});

  @override
  State<MedicalHistoryListPage> createState() => _MedicalHistoryListPage();
}

class _MedicalHistoryListPage extends State<MedicalHistoryListPage> {
  SurgeryMedicalHistory? surgeryMedical;

  Future<SurgeryMedicalHistory> getSurgeryInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/surgery/$id");
    log('data:${response.data}');
    if (response.statusCode == 200) {
      log("ข้อมูลเข้าหรือไม่");

      surgeryMedical = SurgeryMedicalHistory.fromJson(response.data);
      log('surgeryMedical:$surgeryMedical');
      return surgeryMedical!;
    } else {
      throw Exception(
          'Failed to load patients (status code: ${response.statusCode})');
    }
  }

  @override
  Widget InfoRow(String label, String value) {
    return Row(
      children: [
        Text('$label : ',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget medicalStyle(String label, String value) {
    return Row(
      children: [
        Text('$label : ',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[900])),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Medical History List',
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
      body: FutureBuilder(
          future: getSurgeryInfo(widget.surgeryId),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow('รหัสผู้ป่วย',
                            surgeryMedical?.patient.id?.toString() ?? '-'),
                        Row(
                          children: [
                            InfoRow('ชื่อ-นามสกุล',
                                '${surgeryMedical?.patient?.firstname} ${surgeryMedical?.patient.lastname}  '),
                            InfoRow('เพศ',
                                surgeryMedical?.patient.sex?.toString() ?? '-'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ข้อมูลการวินิจฉัย และ การผ่าตัด',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Divider(),
                        InfoRow('Case ID',
                            surgeryMedical?.surgery.case_id?.toString() ?? '-'),
                        InfoRow(
                            'Disease (โรค)',
                            surgeryMedical?.surgery.disease_name?.toString() ??
                                '-'),
                        InfoRow(
                            'Disease note',
                            surgeryMedical?.surgery.disease_note_other
                                    ?.toString() ??
                                '-'),
                        InfoRow(
                            'Surgery type (ประเภทการผ่าตัด)',
                            surgeryMedical?.surgery.surgery_type_name
                                    ?.toString() ??
                                '-'),
                        InfoRow(
                            'Surgery type note',
                            surgeryMedical?.surgery.surgery_type_note_other
                                    ?.toString() ??
                                '-'),
                        InfoRow(
                            'วัน/เดือน/ปี ที่ผ่าตัด',
                            surgeryMedical?.surgery.date_of_surgery
                                    ?.toString() ??
                                '-'),
                        InfoRow('แพทย์ผู้ผ่าตัด',
                            '${surgeryMedical?.surgery.staff_firstname} ${surgeryMedical?.surgery.staff_lastname}'),
                        InfoRow(
                            'ประเภทของ Stoma',
                            surgeryMedical?.surgery.stoma_type_name
                                    ?.toString() ??
                                '-'),
                        InfoRow(
                            'ประเภทของ Stoma',
                            surgeryMedical?.surgery.stoma_type_note_other
                                    ?.toString() ??
                                '-'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalHistoryCreatePage(
                                    surgeryId: widget.surgeryId))).then((onValue) {
                          setState(() {});
                        });
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
                            'เพิ่มการรักษา',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900]),
                          ),
                          Spacer(),
                          Icon(
                            Icons.add,
                            size: 36,
                            color: Colors.green[900],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text('ข้อมูลประวัติการรักษา',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  Divider(),
                  for (var medicalHistory
                      in surgeryMedical?.medical_history ?? <MedicalHistory>[])
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicalHistoryInfoPage(medicalId:medicalHistory.id ),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    medicalStyle('id',
                                        medicalHistory.id.toString() ?? '-'),
                                    medicalStyle(
                                        'วัน-เวลารักษา',
                                        medicalHistory.datetime_of_medical
                                                .toString() ??
                                            '-'),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
