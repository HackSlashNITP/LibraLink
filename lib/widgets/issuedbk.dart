import 'package:flutter/material.dart';
import 'package:libralink/api.dart';
import 'package:libralink/books%20model/issuedbook_model.dart';

class IssuedBookPg extends StatelessWidget {
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
              padding: EdgeInsets.all(0),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _buildBookItem(list[index], context);
              },
            );
            // final bookList = data
            //     .map((doc) => doc.data() as Map<String, dynamic>)
            //     .toList();
            // log(jsonEncode(bookList));
            // for (var book in bookList) {
            //   // log("${book['title']}, ${book['author']}");
            //   return Text("${book['title']}, ${book['author']}");
            // }
          }
        }
        return Center(child: CircularProgressIndicator());
      },
      // return ListView.builder(
      //   padding: EdgeInsets.all(0),
      //       itemCount: items.length,
      //       itemBuilder: (context, index) {
      //         return _buildBookItem(items[index],context);
      //       },
    );
  }

  Widget _buildBookItem(IssuedBook book, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 70,
                      child: Image.asset('assets/images/Group (1).png')),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .06,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Text(
                          'by: ${book.author}',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Issued : \n${book.issuedDate}',
                                  style: TextStyle(fontSize: 10)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .05,
                              ),
                              Text('Return : \n${book.returnDate}',
                                  style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .06),
              child: Container(
                height: MediaQuery.of(context).size.height * .075,
                child: Column(
                  children: [
                    Text(
                      '${book.remainingDays}',
                      style: TextStyle(fontSize: 20, color: Color(0xffFF693D)),
                    ),
                    Text(
                      'days',
                      style: TextStyle(fontSize: 12, color: Color(0xffFF693D)),
                    ),
                    Text(
                      'left',
                      style: TextStyle(fontSize: 10, color: Color(0xffFF693D)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
