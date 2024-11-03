import 'dart:developer';
import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/pages/appliances/appliances_edit_page.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPage();
}

class _ContactPage extends State<ContactPage> {


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
            color: Colors.indigo
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
          'Contact',
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
      body: Padding(
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
                  Text('การติดต่อ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  Divider(),
                  _InfoRow(
                      'เบอร์ติดต่อ','095-781-3390'),
                  _InfoRow('วันเปิดทำการ', 'จันทร์-ศุกร์'),
                  _InfoRow('เวลาทำการ', '8.00-16.00'),
                  _InfoRow('ที่ตั้ง', 'โรงพยาบาล'),
                  _InfoRow('อีเมล', 'ostomy505@hotmail.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
