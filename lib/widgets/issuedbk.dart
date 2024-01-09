import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libralink/api.dart';
import 'package:libralink/books%20model/issuedbook_model.dart';
import 'package:libralink/widgets/bookItem.dart';

class IssuedBookPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: APIs.getIssuedBooks(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                var user_data = snapshot.data!.docs[index].data();
                if (user_data['isReturned'] == false)
                  return buildBookItem(book: user_data);
                else
                  return Container();
              });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
