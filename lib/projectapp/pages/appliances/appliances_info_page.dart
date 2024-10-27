import 'dart:developer';
import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/pages/appliances/appliances_edit_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  Future<bool> deleteAppliances(int id) async {
    try {
      final shouldDelete = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Delete Appliance',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.redAccent,
            ),
          ),
          content: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(child: Text('Are you sure to delete this appliance?')),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final dio = Dio();
                final response =
                    await dio.delete("http://10.0.2.2:3000/appliances/$id");

                log('data:${response.data}');
                log('response.statusCode=${response.statusCode}');

                if (response.statusCode == 200) {
                  Navigator.of(context).pop(true);
                } else {
                  throw Exception(
                      'Failed to load appliance (status code: ${response.statusCode})');
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
              child: new Text(
                'Delete',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // dismisses only the dialog and returns nothing
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[100]),
              child: new Text(
                'cancel',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
          ],
        ),
      );
      if (shouldDelete == true) {
        Navigator.of(context).pop();
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Widget _InfoRow(String label, String value) {
    return Row(
      children: [
        Text('$label : ',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
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
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
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
                        // _InfoRow(
                        //     'รหัสอุปกรณ์', appliances?.id?.toString() ?? '-'),
                        _InfoRow('ประเภท', '${appliances?.type}'),
                        _InfoRow('ยี่ห้อ', '${appliances?.brand}'),
                        _InfoRow('ชื่อแป้นปิดหน้าท้อง',
                            '${appliances?.name_flange}'),
                        _InfoRow('ชื่อถุงรองรับ', '${appliances?.name_pouch}'),
                        _InfoRow('ขนาด', '${appliances?.size}'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (Auth.isAdmin())
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppliancesEditPage(appliancesId: appliances!.id),
                        ),
                      ).then((onValue) {
                        setState(() {});
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45.0),
                        backgroundColor: Colors.yellow[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: TextStyle(color: Colors.white)),
                    child: Text(
                      'edit',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (Auth.isAdmin())
                  ElevatedButton(
                    onPressed: () async {
                      await deleteAppliances(appliances!.id).then((onValue) {
                        setState(() {});
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45.0),
                        backgroundColor: Colors.red[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: TextStyle(color: Colors.white)),
                    child: Text(
                      'delete',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
