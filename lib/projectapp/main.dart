
import 'package:code/projectapp/pages/start_page.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title:'DocProject',
     home:StartPage(),
    );
  }
}
void main(){
  runApp(const MainApp());
}