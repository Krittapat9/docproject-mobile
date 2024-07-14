import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../models/people.dart';
class ListApiPage extends StatefulWidget {
  const ListApiPage({super.key});

  @override
  State<ListApiPage> createState() => _ListApiPage();
}

class _ListApiPage extends State<ListApiPage> {
  final List<People> items = [];
  bool isLoaded= false;

  @override
  void initState() {
    super.initState();
    loadData();
  }
  
  void loadData()async{
    final dio =Dio();
    final response =await dio.get('https://swapi.dev/api/people');
    print(response.data['results']);
    for(var item in response.data['results']){
      items.add(People.fromJson(item));
    }
    setState(() {
      isLoaded=true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('List Items'),
      ),
      body: Column(
        children: [

         if(isLoaded)

          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, int index) {
                
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      print('select on ${items[index].name}');
                    },
                    child: Card(
                      child: Text('item:${items[index].name } ${items[index].birthYear }',
                        key:Key('list-$index'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if(!isLoaded)const Text('Loading...'),
        ],
      ),
    );
  }
}
