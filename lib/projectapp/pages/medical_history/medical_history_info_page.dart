import 'dart:developer';
import 'package:code/projectapp/models/medical_history.dart';
import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/pages/medicine/medicine_list_page.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/pages/setting_page.dart';
import 'package:code/projectapp/pages/staff/staff_work_schedule.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalHistoryInfoPage extends StatefulWidget {
  final int medicalId;

  const MedicalHistoryInfoPage({super.key, required this.medicalId});

  @override
  State<MedicalHistoryInfoPage> createState() => _MedicalHistoryInfoPage();
}

class _MedicalHistoryInfoPage extends State<MedicalHistoryInfoPage> {
  MedicalHistory? medicalHistory;

  Future<MedicalHistory> getMedicalHistory(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/medical_history/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      medicalHistory = MedicalHistory.fromJson(response.data);
      return medicalHistory!;
    } else {
      throw Exception(
          'Failed to load medical (status code: ${response.statusCode})');
    }
  }

  @override
  Widget _InfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Medical Information',
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
                    size: 30,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 140,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(62, 28, 162, 1.0),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 25,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              title: Text(
                'Patient List',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.medical_services,
                size: 25,
              ),
              title: Text(
                'Appilanaces',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppliancesListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.medication_liquid,
                size: 25,
              ),
              title: Text(
                'Medicine',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicineListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                size: 25,
              ),
              title: Text(
                'Work Schedule',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StaffWorkSchedule()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 25,
              ),
              title: Text(
                'Setting',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: getMedicalHistory(widget.medicalId),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ข้อมูลประวัติการรักษา',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Divider(),
                        _InfoRow('Visit ครั้งที่',
                            medicalHistory?.case_id?.toString() ?? '-'),
                        _InfoRow(
                            'วัน/เดือน/ปี',
                            DateFormat('dd / MMM / yyyy | HH:MM:ss').format(
                                medicalHistory?.datetime_of_medical ??
                                    DateTime.now())),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InfoRow('Type of Diversion',
                            '${medicalHistory?.type_of_diversion_name}'),
                        _InfoRow('Type of Diversion Other',
                            '${medicalHistory?.type_of_diversion_note_other}'),
                        _InfoRow('Stoma Construction',
                            '${medicalHistory?.stoma_construction_name}'),
                        Divider(),
                        Center(
                          child: Text('Stoma assessment(การประเมินStoma)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Divider(),
                        _InfoRow('Stoma Color',
                            '${medicalHistory?.stoma_color_name}'),
                        _InfoRow('Stoma Size',
                            'กว้าง ${medicalHistory?.stoma_size_width_mm}mm / ยาว ${medicalHistory?.stoma_size_length_mm}mm'),
                        _InfoRow('Stoma Characteristics',
                            '${medicalHistory?.stoma_characteristics_name}'),
                        _InfoRow('Stoma Characteristics Other',
                            '${medicalHistory?.stoma_characteristics_note_other}'),
                        _InfoRow('Stoma Shape',
                            '${medicalHistory?.stoma_shape_name}'),
                        _InfoRow('Stoma Protrusion',
                            '${medicalHistory?.stoma_protrusion_name}'),
                        _InfoRow('Peristomal skin',
                            '${medicalHistory?.peristomal_skin_name}'),
                        _InfoRow('Mucocutaneous Suture Line',
                            '${medicalHistory?.mucocutaneous_suture_line_name}'),
                        _InfoRow('Mucocutaneous Suture Line Other',
                            '${medicalHistory?.mucocutaneous_suture_line_note_other}'),
                        _InfoRow('Stoma Effluent',
                            '${medicalHistory?.stoma_effluent_name}'),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('Appliances : ',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(62, 28, 162, 1.0),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              child: Text(
                                '${medicalHistory?.appliances_name}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight:
                                        FontWeight.bold), // รูปแบบข้อความ
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Medicine :    ',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(62, 28, 162, 1.0),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              child: Text(
                                '${medicalHistory?.medicine_name}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight:
                                        FontWeight.bold), // รูปแบบข้อความ
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
