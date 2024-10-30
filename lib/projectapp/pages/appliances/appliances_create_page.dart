import 'package:code/projectapp/pages/appliances/appliances_list_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppliancesCreatePage extends StatefulWidget {
  const AppliancesCreatePage({super.key});

  @override
  State<AppliancesCreatePage> createState() => _AppliancesCreatePage();
}

class _AppliancesCreatePage extends State<AppliancesCreatePage> {
  TextEditingController typeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController nameFlangeController = TextEditingController();
  TextEditingController namePouchController = TextEditingController();
  TextEditingController sizeController = TextEditingController();

  void clearForm() {
    typeController.text = '';
    nameController.text = '';
    brandController.text = '';
    nameFlangeController.text = '';
    namePouchController.text = '';
    sizeController.text = '';
  }

  Future<void> _createAppliances() async {
    final dio = Dio();
    final response = await dio.post(
      "http://10.0.2.2:3000/appliances",
      data: {
        'type': typeController.text,
        'name':
            '${brandController.text}\n${nameFlangeController.text}\n${namePouchController.text}',
        'brand': brandController.text,
        'name_flange': nameFlangeController.text,
        'name_pouch': namePouchController.text,
        'size': sizeController.text,
      },
    );
    if (response.statusCode == 200) {
      print('Appliance created successfully!');
      clearForm();
      Navigator.of(context).pop();
    } else {
      print('Error creating appilance: ${response.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Add Appliances',
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
              controller: typeController,
              decoration: InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: brandController,
              decoration: InputDecoration(
                labelText: 'brand',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: nameFlangeController,
              decoration: InputDecoration(
                labelText: 'name flange',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: namePouchController,
              decoration: InputDecoration(
                labelText: 'name pouch',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: sizeController,
              decoration: InputDecoration(
                labelText: 'size',
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
                await _createAppliances();
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
