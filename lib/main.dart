import 'package:code/projectapp//pages/login_page.dart';
import 'package:code/projectapp/pages/home_page.dart';
import 'package:code/projectapp/pages/patient_list_page.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title:'DocProject',
     home:LoginPage(),
    );
  }
}
void main(){
  runApp(const MainApp());
}