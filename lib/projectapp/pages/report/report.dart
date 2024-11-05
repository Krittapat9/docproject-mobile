import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportScreen extends StatefulWidget {
  final int surgeryId;

  const ReportScreen({Key? key, required this.surgeryId}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Map<String, dynamic>? _reportData;
  String? _errorMessage;

  Future<void> fetchReport() async {
    final int surgeryId = widget.surgeryId;

    final response = await http.get(Uri.parse("http://10.0.2.2:3000/report?surgery_id=$surgeryId"));

    if (response.statusCode == 200) {
      setState(() {
        _reportData = json.decode(response.body);
        _errorMessage = null; // Clear any previous error messages
      });
    } else {
      setState(() {
        _errorMessage = "Failed to load report data.";
        _reportData = null;
      });
    }
  }

  List<Widget> buildReportSections(Map<String, dynamic> reportData) {
    return reportData.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${entry.key}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            buildInfoList(entry.key, entry.value as List),
          ],
        ),
      );
    }).toList();
  }

  Widget buildInfoList(String sectionName, List<dynamic> items) {
    return Column(
      children: items.map((item) {
        return Card(
          child: ListTile(
            title: sectionName == "medical_history" && item.containsKey("stoma_size_width_mm") && item.containsKey("stoma_size_length_mm")
                ? Text(
              "Width: ${item['stoma_size_width_mm']} mm, Length: ${item['stoma_size_length_mm']} mm",
              style: TextStyle(fontSize: 14),
            )
                : Text(
              item['appliances_name'] ?? item['medicine_name'] ?? item['stoma_color_name'] ??
                  item['peristomal_skin_name'] ?? item['stoma_characteristics_name'] ??
                  item['stoma_shape_name'] ?? item['stoma_protrusion_name'] ??
                  item['stoma_construction_name'] ?? item['mucocutaneous_suture_line_name'] ??
                  item['stoma_effluent_name'] ?? item['type_of_diversion_name'] ?? 'N/A',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: item.containsKey("number")
                ? Text("จำนวนที่ใช้ : ${item['number']}, จาก Medical_history ครั้งที่: ${item['which_one']}")
                : null,
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Report"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_reportData != null) ...buildReportSections(_reportData!),
            if (_reportData == null && _errorMessage == null)
              Center(child: Text("No data found")),
            if (_errorMessage != null)
              Center(child: Text(_errorMessage!, style: TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }
}