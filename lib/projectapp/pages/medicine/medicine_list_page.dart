import 'dart:developer';

import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/models/medicine.dart';
import 'package:code/projectapp/pages/appliances/appliances_create_page.dart';
import 'package:code/projectapp/pages/appliances/appliances_info_page.dart';
import 'package:code/projectapp/pages/medicine/medicine_create_page.dart';
import 'package:code/projectapp/pages/medicine/medicine_info_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MedicineListPage extends StatefulWidget {
  const MedicineListPage({super.key});

  @override
  State<MedicineListPage> createState() => _MedicineListPage();
}

class _MedicineListPage extends State<MedicineListPage> {
  @override
  bool loading = false;
  List<Medicine> medicineList = [];

  Future<List<Medicine>> getMedicineList() async {
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/medicine");

      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        medicineList = jsonList.map((json) => Medicine.fromJson(json)).toList();
        return medicineList;
      } else {
        // throw Exception(
        //     'Failed to load patients (status code: ${response.statusCode})');
      }
    } catch (error) {
      log('err:$error');
      // throw Exception('Error fetching patients: $error');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Medicine List',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (Auth.isAdmin())
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MedicineCreatePage())).then((onValue) {
                    setState(() {});
                  });
                },
                child: Image.asset(
                  'assets/images/plus-square-white.png',
                  width: 30.0,
                  height: 30.0,
                ))
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Color set here
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Medicine>>(
        future: getMedicineList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No appliances found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final medicine = snapshot.data![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MedicineInfoPage(medicineId: medicine.id),
                    ),
                  ).then((onValue) {
                    setState(() {});
                  });
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  margin: EdgeInsets.all(4.0),
                  child: ListTile(
                    title: Text(
                      '${medicine.name}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.0,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
