import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String name;

  const MainPage(this.name, {super.key});

  @override
  State<StatefulWidget> createState() => _MainPage(name);
}

class _MainPage extends State<MainPage> {
  final String name;

  _MainPage(this.name);

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('Main'),
      ),
      body: Column(
        children: [
          Text('param is $name'),
          Text('counter is $counter'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                counter++;
              });
              print('counter is $counter');
            },
            child: const Text('Click'),
          ),
          ElevatedButton(
            onPressed:() {
            Navigator.pop(context,counter);
          },
            child:const Text('back'),
          ),
        ],
      ),
    );
  }
}
