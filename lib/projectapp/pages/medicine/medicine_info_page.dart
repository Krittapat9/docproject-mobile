import 'dart:developer';
import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/models/medicine.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class MedicineInfoPage extends StatefulWidget {
  final int medicineId;

  const MedicineInfoPage({super.key, required this.medicineId});

  @override
  State<MedicineInfoPage> createState() => _MedicineInfoPage();
}

class _MedicineInfoPage extends State<MedicineInfoPage> {
  Medicine? medicine;

  Future<Medicine> getMedicineInfo(int id) async {
    final dio = Dio();
    final response = await dio.get("http://10.0.2.2:3000/medicine/$id");

    log('data:${response.data}');
    if (response.statusCode == 200) {
      medicine = Medicine.fromJson(response.data);
      return medicine!;
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
          'Medicine Information',
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
          future: getMedicineInfo(widget.medicineId),
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
                        Text('ข้อมูลยา',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Divider(),
                        _InfoRow(
                            'ชื่อยา','${medicine?.name}'),
                        _InfoRow('รายละเอียด', '${medicine?.details}'),
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
