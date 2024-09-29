import 'dart:developer';
import 'package:code/projectapp/models/appliances.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/patient.dart';

class AppliancesInfoPage extends StatefulWidget {
  final int appliancesId;

  const AppliancesInfoPage({super.key, required this.appliancesId});

  @override
  State<AppliancesInfoPage> createState() => _AppliancesInfoPage();
}

class _AppliancesInfoPage extends State<AppliancesInfoPage> {
  Appliances? appliances;

  Future<Appliances> getAppliancesInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/appliances/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      appliances = Appliances.fromJson(response.data);
      return appliances!;
    } else {
      throw Exception(
          'Failed to load appliances (status code: ${response.statusCode})');
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
      body: FutureBuilder(
          future: getAppliancesInfo(widget.appliancesId),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('รายละเอียดอุปกรณ์',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Divider(),
                        _InfoRow(
                            'รหัสอุปกรณ์', appliances?.id?.toString() ?? '-'),
                        _InfoRow('ยี่ห้อ', '${appliances?.brand}'),
                        _InfoRow('ชื่อแป้นปิดหน้าท้อง',
                            '${appliances?.name_flange}'),
                        _InfoRow('ชื่อถุงรองรับ', '${appliances?.name_pouch}'),
                        _InfoRow('ขนาด', '${appliances?.size}'),
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
