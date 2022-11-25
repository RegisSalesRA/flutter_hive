import 'package:flutter/material.dart';

class DeveloperWidget extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final Widget icon;
  final String text;
  final Widget subtitle;

  const DeveloperWidget(
      {Key key,
      this.onTap,
      this.onLongPress,
      this.icon,
      this.text,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: ListTile(
            onTap: onTap,
            onLongPress: onLongPress,
            trailing: icon,
            title: Text(
              text,
              style: Theme.of(context).textTheme.headline2,
            ),
            subtitle: subtitle));
  }
}
