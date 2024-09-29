import 'dart:developer';
import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/models/medical_history.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class MedicalHistoryInfoPage extends StatefulWidget {


  const MedicalHistoryInfoPage({super.key});

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
    return Row(
      children: [
        Text('$label : ',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
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
          'Appliances Information',
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
      // body: FutureBuilder(
      //     future: getMedicalHistory(),
      //     builder: (context, snapshot) {
      //       return Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Container(
      //               padding: EdgeInsets.all(14),
      //               decoration: BoxDecoration(
      //                 border: Border.all(color: Colors.black),
      //                 borderRadius: BorderRadius.circular(8),
      //               ),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text('รายละเอียดประวัติการรักษา',
      //                       style: TextStyle(
      //                           fontWeight: FontWeight.bold, fontSize: 18)),
      //                   Divider(),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     }),
    );
  }
}
