import 'package:code/projectapp/models/work_schedule.dart';
import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:code/projectapp/pages/medicine/medicine_list_page.dart';
import 'package:code/projectapp/pages/patient/patient_appointment_page.dart';
import 'package:code/projectapp/pages/patient/patient_create_page.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:code/projectapp/pages/patient/patient_list_page.dart';
import 'package:code/projectapp/pages/setting_page.dart';
import 'package:code/projectapp/pages/staff/staff_edit_password.dart';
import 'package:code/projectapp/pages/staff/staff_list.dart';
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
  int notificationCount = 0;

  Future<bool> loadAppointmentUpcoming(int patientId) async {
    try {
      final dio = Dio();
      final response = await dio
          .get("http://10.0.2.2:3000/appointment/patient/$patientId/upcoming");

      if (response.statusCode == 200) {
        List jsonList = response.data;

        setState(() {
          notificationCount = jsonList
              .map((json) => WorkSchedule.fromJson(json))
              .toList()
              .length;
          print("notificationCount: $notificationCount");
        });
      } else {
        throw Exception(
            'Failed to load patients (status code: ${response.statusCode})');
      }
    } on Exception catch (e) {}
    return true;
  }

  String get _fullName {
    if (Auth.currentUser != null &&
        Auth.currentUser?.firstname != null &&
        Auth.currentUser?.lastname != null) {
      return '${Auth.currentUser!.firstname} ${Auth.currentUser!.lastname} ';
    } else if (AuthPatient.currentUser != null &&
        AuthPatient.currentUser?.firstname != null &&
        AuthPatient.currentUser?.lastname != null) {
      return '${AuthPatient.currentUser!.firstname} ${AuthPatient.currentUser!.lastname} ';
    } else {
      return 'Guest';
    }
  }

  // String get _userId =>
  //     Auth.currentUser?.id != null ? '${Auth.currentUser!.id}' : 'Guest';
@override
void initState() {
  super.initState();
  Future.delayed(Duration.zero, () async {
    try {
      if (Auth.currentUser!.is_admin == 0 && Auth.currentUser!.first_login == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StaffEditPasswordPage(),
          ),
        );
      }
    } catch (e) {
      print('Navigation Error: $e');
    }
  });

  try {
    loadAppointmentUpcoming(AuthPatient.currentUser!.id);
  } catch (e) {
    // handle load error here
    print('Loading Appointment Error: $e');
  }
}

  Widget menuButton(
    String label,
    String iconPath,
    void Function() onClick, {
    int notification = 0,
  }) {
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
            height: 70,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Color.fromRGBO(62, 28, 168, 1.0),
            ),
          ),
          if (notification > 0)
            Column(
              children: [
                SizedBox(height: 2,),
                Container(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Text(
                      '$notification',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userType;
    if (Auth.isAdmin()) {
      userType = 'Admin';
    } else if (Auth.isStaff()) {
      userType = 'medical personnel';
    } else if (AuthPatient.isPatient()) {
      userType = 'patient';
    } else {
      userType = 'guest';
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello, $_fullName \n',
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'User : $userType',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
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
              if (!Auth.isStaff() && !Auth.isAdmin())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: menuButton(
                    'Appointment',
                    'assets/images/calendar3.png',
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PatientAppointmentPage(),
                        ),
                      );
                    },
                    notification: notificationCount,
                  ),
                ),
              if (Auth.isAdmin())
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: menuButton(
                  'Staff List',
                  'assets/images/staff.png',
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => StaffListPage()),
                    );
                  },
                ),
              ),
              if (Auth.isStaff() || Auth.isAdmin())
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
              if (Auth.isStaff() || Auth.isAdmin())
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
