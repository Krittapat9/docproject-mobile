import 'dart:developer';
import 'package:code/projectapp/models/medical_history.dart';
import 'package:code/projectapp/models/surgery.dart';
import 'package:code/projectapp/models/surgery_medical_history.dart';
import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/pages/medical_history/medical_history_create_page.dart';
import 'package:code/projectapp/pages/medical_history/medical_history_info_page.dart';
import 'package:code/projectapp/pages/medicine/medicine_list_page.dart';
import 'package:code/projectapp/pages/patient/contact.dart';
import 'package:code/projectapp/pages/patient/patient_appointment_page.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/pages/setting_page.dart';
import 'package:code/projectapp/pages/staff/staff_list.dart';
import 'package:code/projectapp/pages/staff/staff_register_pager.dart';
import 'package:code/projectapp/pages/staff/staff_work_schedule.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:code/projectapp/pages/report/report.dart'; // นำเข้าหน้า ReportScreen

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

  void report() {
    log("Report button clicked");
    // Navigating to ReportScreen with the surgeryId
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportScreen(surgeryId: widget.surgeryId), // ส่ง surgeryId ไปที่ ReportScreen
      ),
    ).then((_) {
      // อัปเดตหน้าหลังจากกลับจาก ReportScreen
      setState(() {});
    });
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
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.green),
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
            if (Auth.isAdmin())
              ListTile(
                leading: Icon(
                  Icons.add,
                  size: 25,
                ),
                title: Text(
                  'Register Staff',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StaffRegisterPage()),
                  );
                },
              ),
            if (Auth.isAdmin())
              ListTile(
                leading: Icon(
                  Icons.person,
                  size: 25,
                ),
                title: Text(
                  'Staff List',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StaffListPage()),
                  );
                },
              ),
            if (!Auth.isStaff() && !Auth.isAdmin())
              ListTile(
                leading: Icon(
                  Icons.person,
                  size: 25,
                ),
                title: Text(
                  'My Infomation',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientInfoPage(
                            patientId: AuthPatient.currentUser!.id)),
                  );
                },
              ),
            if (!Auth.isStaff() && !Auth.isAdmin())
              ListTile(
                leading: Icon(
                  Icons.calendar_month,
                  size: 25,
                ),
                title: Text(
                  'My Appointment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientAppointmentPage()),
                  );
                },
              ),
            if (!Auth.isStaff() && !Auth.isAdmin())
              ListTile(
                leading: Icon(
                  Icons.phone,
                  size: 25,
                ),
                title: Text(
                  'Contact',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                },
              ),
            if (Auth.isStaff())
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
            if (Auth.isStaff() || Auth.isAdmin())
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
                    MaterialPageRoute(
                        builder: (context) => AppliancesListPage()),
                  );
                },
              ),
            if (Auth.isStaff() || Auth.isAdmin())
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
            if (Auth.isStaff())
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
                    MaterialPageRoute(
                        builder: (context) => StaffWorkSchedule()),
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
                        Row(
                          children: [
                            InfoRow('ชื่อ-นามสกุล',
                                '${surgeryMedical?.patient?.firstname} ${surgeryMedical?.patient.lastname}  '),
                            InfoRow('เพศ',
                                surgeryMedical?.patient.sex?.toString() ?? '-'),
                          ],
                        ),
                        Row(
                          children: [
                            InfoRow(
                                'วัน/เดือน/ปีเกิด',
                                surgeryMedical?.patient.date_of_birth != null
                                    ? DateFormat('dd / MMM / yyyy').format(
                                        surgeryMedical!.patient.date_of_birth!
                                            .add(Duration(hours: 7)))
                                    : '-'),
                            InfoRow(
                              '   อายุ',
                              surgeryMedical?.patient.date_of_birth != null
                                  ? '${DateTime.now().year - surgeryMedical!.patient.date_of_birth!.year} ปี'
                                  : '-',
                            ),
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
                            'วัน/เดือน/ปี ที่วินิจฉัย',
                            surgeryMedical?.surgery.date_of_surgery != null
                                ? DateFormat('dd / MMM / yyyy').format(
                                    surgeryMedical!.surgery.date_of_surgery!
                                        .add(Duration(hours: 7)))
                                : '-'),
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
                  if (Auth.isStaff())
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MedicalHistoryCreatePage(
                                              surgeryId: widget.surgeryId)))
                              .then((onValue) {
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
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: report,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Report',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(width: 5),
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
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Divider(),
                  for (var medicalHistory
                      in surgeryMedical?.medical_history ?? <MedicalHistory>[])
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicalHistoryInfoPage(
                                medicalId: medicalHistory.id),
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
                                    medicalStyle(
                                        'Visit',
                                        medicalHistory.case_id.toString() ??
                                            '-'),
                                    medicalStyle(
                                      'วัน-เวลารักษา',
                                      DateFormat('dd / MMM / yyyy - HH:mm')
                                          .format(
                                        (medicalHistory?.datetime_of_medical ??
                                                DateTime.now())
                                            .add(Duration(hours: 7)),
                                      ),
                                    ),
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
