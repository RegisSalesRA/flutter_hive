import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:flutter_hive/screens/forms/update_developer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'forms/create_developer.dart';

class NotGraduated extends StatefulWidget {
  @override
  _NotGraduatedState createState() => _NotGraduatedState();
}

class _NotGraduatedState extends State<NotGraduated> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DeveloperCreate()),
          );
        },
      ),
      appBar: AppBar(
        title: Text("Hive Form incomleto"),
        centerTitle: true,
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Developer>('developers').listenable(),
          builder: (context, Box<Developer> box, _) {
            List<int> keys;

            keys = box.keys
                .cast<int>()
                .where((key) => box.get(key).isGraduated == false)
                .toList();

            print(keys);

            if (box.values.isEmpty) {
              return Center(
                child: Text("No data available!",
                    style: TextStyle(fontFamily: 'Montserrat')),
              );
            }
            return ListView.builder(
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  final int key = keys[index];
                  final Developer form = box.get(key);

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeveloperUpdate(
                                    id: index,
                                    nomeChange: form.nome,
                                  )));
                    },
                    onLongPress: () async {
                      await box.deleteAt(index);
                    },
                    trailing: Icon(
                      form.isGraduated
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.blue,
                    ),
                    title: Text(
                      form.nome,
                      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    ),
                    subtitle: form.choices == null
                        ? Text("Unknow")
                        : Text(form.choices),
                  );
                });
          },
        ),
      ),
    );
  }
}
