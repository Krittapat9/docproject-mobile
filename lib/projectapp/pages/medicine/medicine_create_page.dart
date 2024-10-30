import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:code/projectapp/pages/medicine/medicine_list_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MedicineCreatePage extends StatefulWidget {
  const MedicineCreatePage({super.key});

  @override
  State<MedicineCreatePage> createState() => _MedicineCreatePage();
}

class _MedicineCreatePage extends State<MedicineCreatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  void clearForm() {
    nameController.clear();
    detailsController.clear();
  }

  Future<void> _createMedicine() async {
    final dio = Dio();
    final response = await dio.post(
      "http://10.0.2.2:3000/medicine",
      data: {
        'name': nameController.text,
        'details': detailsController.text,
      },
    );
    if (response.statusCode == 200) {
      print('Medicine created successfully!');
      clearForm();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MedicineListPage(),
        ),
      );
    } else {
      print('Error creating medicine: ${response.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Add Medicine',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'ชื่อยา',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(
                labelText: 'รายละเอียดยา',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                await _createMedicine();
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
                textStyle: TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
