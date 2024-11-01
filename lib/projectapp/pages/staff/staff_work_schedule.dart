import 'dart:developer';

import 'package:code/projectapp/models/work_schedule.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StaffWorkSchedule extends StatefulWidget {
  const StaffWorkSchedule({super.key});

  @override
  State<StaffWorkSchedule> createState() => _StaffWorkSchedule();
}

class _StaffWorkSchedule extends State<StaffWorkSchedule> {
  DateTime _selectedTimeNow = DateTime.now();
  List<WorkSchedule> workScheduleList = [];
  final DatePickerController _controller = DatePickerController();

  Future<List<WorkSchedule>> getWorkSchedule(
      int? id, DateTime workDate) async {
    try {
      var dateFormat = DateFormat('yyyy-MM-dd').format(workDate);
      final dio = Dio();
      final response = await dio.get(
        "http://10.0.2.2:3000/schedule/staff/$id/$dateFormat",
      );

      log('schedule:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        return jsonList.map((json) => WorkSchedule.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load work schedule (status code: ${response.statusCode})');
      }
    } catch (error) {
      log('err:$error');
    }
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      workScheduleList =
          await getWorkSchedule(Auth.currentUser?.id, _selectedTimeNow);
      _controller.animateToDate(_selectedTimeNow,
          duration: Duration(milliseconds: 900));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Work Schedule',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DatePicker(
              DateTime.now().subtract(Duration(days: 90)),
              controller: _controller,
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              dateTextStyle:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              dayTextStyle: const TextStyle(
                fontSize: 15,
              ),
              monthTextStyle: const TextStyle(
                fontSize: 15,
              ),
              onDateChange: (date) async {
                // New date selected
                _selectedTimeNow = date;
                workScheduleList = await getWorkSchedule(
                    Auth.currentUser?.id, _selectedTimeNow);
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: workScheduleList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                        itemCount: workScheduleList.length,
                        itemBuilder: (context, index) {
                          var workSchedule = workScheduleList[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientInfoPage(
                                      patientId: workSchedule.patient_id),
                                ),
                              ).then((val) {
                                setState(() {
                                  print('return 2');
                                });
                              });
                            },
                            child: Card(
                              elevation: 6,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              margin: EdgeInsets.all(5.0),
                              child: ListTile(
                                title: Text(
                                  '${workSchedule.patient_firstname} ${workSchedule.patient_lastname}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Work date: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd / MMM / yyyy').format(
                                              workSchedule.work_date
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
                                          '${workSchedule.start_time} - ${workSchedule.end_time}',
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
                              ),
                            ),
                          );
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Divider(),
                        Text('not found work'),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
