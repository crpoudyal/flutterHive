import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hive"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder(
                future: Hive.openBox('hivebox'),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Text(snapshot.data!.get('name').toString()),
                      Text(snapshot.data!.get('List').toString()),
                      Text(snapshot.data!.get('name').toString()),
                    ],
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('hivebox');
          var box2 = await Hive.openBox('hivebox2');

          box.put('name', 'crpoudyal');
          box.put('pro', 'Developer');
          box.put('List', {'age': 24, 'address': 'Brt'});

          print(box.get('name'));
          print(box.get('List')['age']);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
