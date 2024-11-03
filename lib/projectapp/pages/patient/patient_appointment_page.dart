import 'dart:developer';
import 'package:code/projectapp/models/work_schedule.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientAppointmentPage extends StatefulWidget {
  const PatientAppointmentPage({super.key});

  @override
  State<PatientAppointmentPage> createState() => _PatientAppointmentPage();
}

class _PatientAppointmentPage extends State<PatientAppointmentPage> {
  @override
  List<WorkSchedule> appointmentList = [];
  List<WorkSchedule> appointmentHistoryList = [];

  Future<List<WorkSchedule>> getPatientAppointment() async {
    try {
      final dio = Dio();
      log('Appointment List: $appointmentList');
      final response = await dio.get(
          "http://10.0.2.2:3000/appointment/patient/${AuthPatient.currentUser!.id}");

      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        appointmentList =
            jsonList.map((json) => WorkSchedule.fromJson(json)).toList();
        return appointmentList;
      } else {
        throw Exception(
            'Failed to load patients (status code: ${response.statusCode})');
      }
    } catch (error) {
      log('err:$error');
    }
    return [];
  }

  Future<List<WorkSchedule>> getPatientAppointmentHistory() async {
    try {
      final dio = Dio();
      final response = await dio.get(
          "http://10.0.2.2:3000/appointment/patient/${AuthPatient.currentUser!.id}/history");

      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        appointmentHistoryList =
            jsonList.map((json) => WorkSchedule.fromJson(json)).toList();
        return appointmentHistoryList;
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
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
            bottom: const TabBar(
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 6.0,
                  ),
                ),
              ),
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                  size: 30,
                )),
                Tab(
                  icon: Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            title: const Text(
              'My Appointment',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              // Color set here
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<WorkSchedule>>(
                        future: getPatientAppointment(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error:${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No appointments'));
                          }
                      
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final appointment = snapshot.data![index];
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  margin: EdgeInsets.all(4.0),
                                  child: ListTile(
                                    title: Text(
                                      '${appointment.patient_firstname} ${appointment.patient_lastname}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'appointment date: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd / MMM / yyyy').format(
                                                  appointment.work_date
                                                      .add(Duration(hours: 7))),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'time : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '${appointment.start_time} - ${appointment.end_time}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'email: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(appointment.patient_email,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'detail: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(appointment.detail,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size: 24.0,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<WorkSchedule>>(
                        future: getPatientAppointmentHistory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error:${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No appointments'));
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final appointment = snapshot.data![index];
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  margin: EdgeInsets.all(4.0),
                                  child: ListTile(
                                    title: Text(
                                      '${appointment.patient_firstname} ${appointment.patient_lastname}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'appointment date: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd / MMM / yyyy').format(
                                                  appointment.work_date
                                                      .add(Duration(hours: 7))),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'time : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '${appointment.start_time} - ${appointment.end_time}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                fontSize: 18,
                                              ),
                                            ),

                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              'email : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              appointment.patient_email,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),

                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'detail : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              appointment.detail,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 18,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 24.0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
