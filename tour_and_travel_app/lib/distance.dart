import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Distance extends StatelessWidget {
  const Distance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Rating -",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 3),
        const SizedBox(width: 3),
        Icon(
          Ionicons.star,
          size: 18,
          color: Colors.yellow,
        ),
        Icon(
          Ionicons.star,
          size: 18,
          color: Colors.yellow,
        ),
        Icon(
          Ionicons.star,
          size: 18,
          color: Colors.yellow,
        ),
        Icon(
          Ionicons.star,
          size: 18,
          color: Colors.yellow,
        ),
        Icon(
          Ionicons.star_half,
          size: 18,
          color: Colors.yellow,
        ),
        const SizedBox(width: 2),
        Text(
          "Kumasi",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
