import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/developer.dart';

showDialogWidget(
    BuildContext context, Developer dev, Box<Developer> box) async {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Alert'),
      content: Text('Wish delete ${dev.name} ?'),
      actions: <Widget>[
        Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await box.delete(dev.key);

              Navigator.pop(context, 'Confirm');
            },
            child: const Text('Confirm'),
          ),
        ])),
      ],
    ),
  );
}
