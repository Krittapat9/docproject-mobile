import 'dart:developer';

import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/pages/patient/patient_create_page.dart';
import 'package:code/projectapp/pages/patient/patient_info_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientAppointmentPage extends StatefulWidget {
  const PatientAppointmentPage({super.key});

  @override
  State<PatientAppointmentPage> createState() => _PatientAppointmentPage();
}

class _PatientAppointmentPage extends State<PatientAppointmentPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calendar_month_outlined)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
            title: const Text('Appointment'),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemBuilder: (ctx, idx) => Text("$idx"),
                itemCount: 50,
              ),
              ListView.builder(
                itemBuilder: (ctx, idx) => Text("$idx"),
                itemCount: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
