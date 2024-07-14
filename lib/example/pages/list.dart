import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  final List<int> items = [
    for (int i = 1; i <= 100; i++) i,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('List Items'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  items.add(items.last+1);
                });
              },
              child:const Text('Add new Item'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, int index) {
                return Text('item:${items[index]}',
                  key:Key('list-$index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
