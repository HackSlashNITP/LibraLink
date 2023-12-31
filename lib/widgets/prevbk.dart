import 'package:flutter/material.dart';
import 'package:libralink/api.dart';
import 'package:libralink/books%20model/privious_issuedbook_model.dart';
import '../books model/previous.dart';
class PreviousBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       return StreamBuilder(
      stream: APIs.getPriviousIssuedBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => PriviousIssueBook.fromJson(e.data())).toList() ??
                  [];
          if (data != null) {
            return ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _buildPreviousBookItem(list[index], context);
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
    ); }
  }

Widget _buildPreviousBookItem(PriviousIssueBook bk, BuildContext context) {
  return Card(
     margin: EdgeInsets.symmetric(vertical: 2),
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .025),
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
                        '${bk.title}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Text(
                        'by : ${bk.author}',
                        style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Issued : \n${bk.issuedDate}',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[700]),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Text('Return : \n${bk.returned}',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[700])),
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
                  right: MediaQuery.of(context).size.width * .04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    bk.isPaid ? 'Paid' : 'Due',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: (bk.isPaid) ? Colors.green : Colors.orange,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'fine : ${bk.fineAmount}',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${bk.lateDays}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'days late',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              )),
        ],
      ),
    ),
  );}



  