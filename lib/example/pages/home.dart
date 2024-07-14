import 'package:code/example/pages/list.dart';
import 'package:code/example/pages/list_api.dart';
import 'package:code/example/pages/list_api_2.dart';
import 'package:code/example/pages/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              int returnedCounter =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MainPage("From Home Page"),
              ));
              print('returnedCounter is $returnedCounter');
            },
            child: const Text('Go to Main Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ListPage(),
              ));
            },
            child: const Text('Go to List Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ListApiPage()
              ));
            },
            child: const Text('Go to List Api Page'),
          ),
          ElevatedButton(
              onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=> ListApi2Page()
            ));
          }, child: const Text('ListApi2Page'))
        ],
      ),
    );
  }
}
