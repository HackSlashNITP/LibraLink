import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text("Dues"),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        )
      ],
    );
  }
}
