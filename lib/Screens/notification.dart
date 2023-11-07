import 'package:flutter/material.dart';
import 'package:libralink/books%20model/books.dart';
import 'package:libralink/widgets/bookwidget.dart';

class notification extends StatelessWidget {
  const notification({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
          title: Text(
            "Notification",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: libmodel.books.length,
                itemBuilder: (context, index) {
                  return bookwidget(book: libmodel.books[index]);
                },
              ),
            )
          ],
        ));
  }
}
