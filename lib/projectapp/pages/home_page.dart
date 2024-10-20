import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:code/projectapp/pages/medicine/medicine_list_page.dart';
import 'package:code/projectapp/pages/patient/patient_create_page.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/pages/setting_page.dart';
import 'package:code/projectapp/pages/staff/staff_register_pager.dart';
import 'package:code/projectapp/pages/staff_work_schedule.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String get _fullName =>
      Auth.currentUser?.firstname != null && Auth.currentUser?.lastname != null
          ? '${Auth.currentUser!.firstname} ${Auth.currentUser!.lastname} '
          : 'Guest';

  String get _userId =>
      Auth.currentUser?.id != null ? '${Auth.currentUser!.id}' : 'Guest';

  Widget menuButton(String label, String iconPath, void Function() onClick) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 60,
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Color.fromRGBO(62, 28, 168, 1.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello, $_fullName \n',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'staff id : $_userId',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ],
            ),
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
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1000),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 180,
            ),
            children: [
              if (Auth.isStaff())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: menuButton(
                    'Patient List',
                    'assets/images/patient.png',
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PatientListPage()),
                      );
                    },
                  ),
                ),
              if (Auth.isStaff())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: menuButton(
                    'Add Patient',
                    'assets/images/add-user.png',
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PatientCreatePage()),
                      );
                    },
                  ),
                ),
              //ADMIN
              if (Auth.isAdmin())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: menuButton(
                    'Register Staff',
                    'assets/images/doctor.png',
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StaffRegisterPage()),
                      );
                    },
                  ),
                ),
              if (!Auth.isStaff() && !Auth.isAdmin())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: menuButton(
                    'My Information',
                    'assets/images/patient.png',
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PatientInfoPage(
                              patientId: AuthPatient.currentUser!.id),
                        ),
                      );
                    },
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: menuButton(
                  'Appliances',
                  'assets/images/first-aid-kit.png',
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AppliancesListPage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: menuButton(
                  'Medicine',
                  'assets/images/drugs.png',
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MedicineListPage()),
                    );
                  },
                ),
              ),
              if (Auth.isStaff())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: menuButton(
                    'Work Schedule',
                    'assets/images/calendartime.png',
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StaffWorkSchedule()),
                      );
                    },
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: menuButton(
                  'Setting',
                  'assets/images/settings.png',
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
