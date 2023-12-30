import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../books model/issuedbook_model.dart';

class duesBook extends StatefulWidget {
  const duesBook({super.key});

  @override
  State<duesBook> createState() => _duesBookState();
}

class _duesBookState extends State<duesBook> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: APIs.getIssuedBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => IssuedBook.fromJson(e.data())).toList() ?? [];
          if (data != null) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _BookItem(list[index], context);
                });
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _BookItem(IssuedBook book, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: new BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              '${book.title}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Text(
              '${book.issuedDate}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Text(
              (() {
                DateFormat dateFormat = DateFormat('dd-MM-yyyy');
                DateTime issuedDate = dateFormat.parse(book.issuedDate);
                DateTime returnDate = dateFormat.parse(book.returnDate);
                int daysDifference =
                    returnDate.difference(issuedDate).inDays - 14;

                return (daysDifference > 0) ? '$daysDifference' : '0';
              })(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
