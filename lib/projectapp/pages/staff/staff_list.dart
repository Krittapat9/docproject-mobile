import 'dart:developer';
import 'package:code/projectapp/models/staff.dart';
import 'package:code/projectapp/pages/staff/staff_edit_page.dart';
import 'package:code/projectapp/pages/staff/staff_register_pager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StaffListPage extends StatefulWidget {
  const StaffListPage({super.key});

  @override
  State<StaffListPage> createState() => _StaffListPage();
}

class _StaffListPage extends State<StaffListPage> {
  @override
  List<Staff> staff = [];
  String searchBox = '';

  Future<List<Staff>> getStaffList([String query = '']) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "http://10.0.2.2:3000/staff",
        queryParameters: {'q': query},
      );

      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        return jsonList
            .map((json) => Staff.fromJson(json))
            .where((staff) => staff.is_admin == 0)
            .toList();
      } else {
        throw Exception(
            'Failed to load staff (status code: ${response.statusCode})');
      }
    } catch (error) {
      log('err:$error');
    }
    return [];
  }

  Future<bool> deleteStaff(int staffId) async {
    try {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Delete Staff',
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
              Expanded(child: Text('Are you sure to delete this staff?')),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final dio = Dio();
                final response =
                    await dio.delete("http://10.0.2.2:3000/staff/$staffId");

                log('data:${response.data}');
                log('response.statusCode=${response.statusCode}');
                if (response.statusCode == 200) {
                } else {
                  throw Exception(
                      'Failed to load patients (status code: ${response.statusCode})');
                }
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
              child: new Text(
                'OK',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text(
                'cancel',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: Text(
          'Staff List',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StaffRegisterPage()))
                    .then((onValue) {
                  setState(() {});
                });
              },
              child: Image.asset(
                'assets/images/doctorwhite.png',
                width: 40.0,
                height: 40.0,
              ))
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Color set here
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchBox = value;
                });
                getStaffList(searchBox);
              },
              decoration: InputDecoration(
                labelText: 'Search staff name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Staff>>(
              future: getStaffList(searchBox),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error:${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No staff found.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final staff = snapshot.data![index];
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 6,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        margin: EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                child: Center(
                                  child: Text(
                                    '${staff.firstname} ${staff.lastname}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Center(
                                  child: Text(
                                    'username : ${staff.username}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StaffEditPage(
                                                      staffId:staff!.id),
                                            ),
                                          ).then((onValue) {
                                            setState(() {});
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: Text(
                                          'edit',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await deleteStaff(staff!.id)
                                            .then((onValue) {
                                          setState(() {});
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[900],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      child: Text(
                                        'delete',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
