import 'package:flutter/material.dart';
import 'package:libralink/books%20model/books.dart';

class bookwidget extends StatefulWidget {
  final lib book;
  const bookwidget({super.key, required this.book}) : assert(book != null);

  @override
  State<bookwidget> createState() => _bookwidgetState();
}

class _bookwidgetState extends State<bookwidget> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: Icon(
            Icons.notifications_active,
            color: Colors.black,
          ),
          subtitle: Text(
              "Return ${widget.book.name} will be expire on ${widget.book.date}."),
          trailing: Text("${widget.book.time} h",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              )),
        ),
      ),
    );
    ;
  }
}
