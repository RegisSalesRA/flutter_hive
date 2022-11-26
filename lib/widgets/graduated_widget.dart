

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/developer.dart';
import '../screens/forms/form.dart';
import 'widget.dart';

class GraduatedWidget extends StatelessWidget {
  const GraduatedWidget({
    Key key,
    @required this.boxform,
    @required this.size,
  }) : super(key: key);

  final ValueListenable<Box<Developer>> boxform;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxform,
      builder: (context, Box<Developer> box, _) {
        List<int> keys;

        keys = box.keys
            .cast<int>()
            .where((key) => box.get(key).isGraduated)
            .toList();

        if (box.values.isEmpty) {
          return SizedBox(
            height: size.height * 0.50,
            child: Center(
              child: Text("No graduated available!",
                  style: TextStyle(fontFamily: 'Montserrat')),
            ),
          );
        }
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final int key = keys[index];
              final Developer dev = box.get(key);

              return DeveloperWidget(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormDeveloper(
                                id: index,
                                nameChange: dev.name,
                              )));
                },
                onLongPress: () async {
                  await showDialogWidget(context, dev, box);
                },
                icon: Icon(
                  dev.isGraduated ? Icons.school : Icons.person,
                  size: 30,
                  color: Theme.of(context).iconTheme.color,
                ),
                text: dev.name ?? "default",
                subtitle: dev.choices == null
                    ? Text(
                        "Unknow",
                      )
                    : Text(
                        dev.choices,
                      ),
              );
            });
      },
    );
  }
}

