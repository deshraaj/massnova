import 'package:flutter/material.dart';

class ReusableTile extends StatelessWidget {
  final String title, data;
  final IconData iconData;

  const ReusableTile(
      {Key? key,
        required this.title,
        required this.data,
        required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(iconData),
          title: Text(title),
          trailing: Text(data),
        ),
        const Divider(
          thickness: 2,
        )
      ],
    );
  }
}