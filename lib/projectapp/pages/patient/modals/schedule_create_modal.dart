import 'dart:developer';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCreateModal extends StatefulWidget {
  final int patientId;

  ScheduleCreateModal({super.key, required this.patientId});

  @override
  State<ScheduleCreateModal> createState() => _ScheduleCreateModal();
}

class _ScheduleCreateModal extends State<ScheduleCreateModal> {
  TextEditingController workDateController = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void clearForm() {
    workDateController.clear();
    startTime = null;
    endTime = null;
  }

  List<String> scheduleStartTimes = [
    '8:00',
    '9.00',
    '10.00',
    '11.00',
    '13.00',
    '14.00',
    '15.00'
  ];
  List<String> scheduleEndTimes = [
    '9.00',
    '10.00',
    '11.00',
    '12.00',
    '14.00',
    '15.00',
    '16.00'
  ];

  Future<void> _createSchedule() async {
    if (startTime == null ||
        endTime == null ||
        workDateController.text.isEmpty) {
      // Show an error message if required fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select start time, end time, and date'),
        ),
      );
      return;
    }

    final dio = Dio();
    final response = await dio.post(
      "http://10.0.2.2:3000/schedule",
      data: {
        'work_date': workDateController.text,
        'start_time': startTime!.format(context),
        'end_time': endTime!.format(context),
        'patient_id': widget.patientId,
        'staff_id': Auth.currentUser?.id,
      },
    );
    if (response.statusCode == 200) {
      print('work schedule created successfully!');
      clearForm();
      Navigator.of(context).pop();
      // setState(() async {
      //
      // });
    } else {
      print('Error creating work schedule: ${response.data}');
    }
  }

  Widget buildTimeSelection(List<String> times, String? selectedTime,
      Function(String) onTimeSelected) {
    return Wrap(
      spacing: 10.0, // ระยะห่างระหว่างปุ่ม
      children: times.map((time) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              onTimeSelected(time);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedTime == time
                ? Colors.blue
                : Colors.grey, // เปลี่ยนสีปุ่มที่เลือก
          ),
          child: Text(time),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: Text('นัดหมาย',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
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
                        lastDate: d.add(const Duration(days: 90)),
                      );
                      if (pickedDate != null) {
                        print(
                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        print(
                            formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                        setState(() {
                          workDateController.text =
                              formattedDate; //set foratted date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Text('Start time'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var time in scheduleStartTimes)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          var h = int.parse(time.split(':')[0]);
                          var m = int.parse(time.split(':')[1]);
                          startTime = TimeOfDay(hour: h, minute: m);
                        },
                        child: Text(time),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text('End time'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var time in scheduleEndTimes)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(time),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _createSchedule();
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
                  backgroundColor: const Color.fromRGBO(62, 28, 168, 1.0),
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
}
