import 'package:flutter/material.dart';
import 'package:flutterhive/boxes/boxes.dart';
import 'package:flutterhive/model/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hive"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].title.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(data[index].description.toString()),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Notes"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: "Enter Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Enter Description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  final data = NotesModel(
                    title: titleController.text.toString(),
                    description: descriptionController.text.toString(),
                  );

                  final box = Boxes.getData();
                  box.add(data);
                  data.save();
                  // Clearing text after adding
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          );
        });
  }
}
