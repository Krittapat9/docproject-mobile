import 'dart:developer';

import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/pages/appliances/appliances_create_page.dart';
import 'package:code/projectapp/pages/appliances/appliances_info_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppliancesListPage extends StatefulWidget {
  const AppliancesListPage({super.key});

  @override
  State<AppliancesListPage> createState() => _AppliancesListPage();
}

class _AppliancesListPage extends State<AppliancesListPage> {
  @override
  bool loading = false;
  List<Appliances> appliancesList = [];

  Future<List<Appliances>> getAppliancesList() async {
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/appliances");

      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        appliancesList =
            jsonList.map((json) => Appliances.fromJson(json)).toList();
        return appliancesList;
      } else {

      }throw Exception(
          'Failed to load appliance (status code: ${response.statusCode})');
    } catch (error) {
      log('err:$error');
      throw Exception('Error fetching appliance: $error');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Appliances List',
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
                        builder: (context) => AppliancesCreatePage()));
              },
              child: Image.asset(
                'assets/images/plus-square-white.png',
                width: 30.0,
                height: 30.0,
              ),
            ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Color set here
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Appliances>>(
        future: getAppliancesList(),
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
              final appliances = snapshot.data![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AppliancesInfoPage(appliancesId: appliances.id),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  margin: EdgeInsets.all(4.0),
                  child: ListTile(
                    title: Text(
                      '${appliances.brand}\n${appliances.name_flange}\n${appliances.name_pouch}',
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
