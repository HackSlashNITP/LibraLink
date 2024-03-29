import 'package:flutter/material.dart';
import 'package:libralink/routes/mapping.dart';

class buildBookItem extends StatelessWidget {
  final book;
  const buildBookItem({required this.book});
  @override
  Widget build(BuildContext context) {
    DateTime issuedDate = DateTime.parse(book['issued_date']);
    DateTime returnDate = DateTime.parse(book['returndate']);
    int remainingDays = returnDate.difference(issuedDate).inDays;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.returnRoute,
            arguments: {'book': book});
      },
      child: Card(
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
                            book['title'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Text(
                            'by: ${book['author']}',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[700]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Issued : \n${book['issued_date']}',
                                    style: TextStyle(fontSize: 10)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .05,
                                ),
                                Text('Return : \n${book['returndate']}',
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!book['isReturned']) ...[
                        Text(
                          // '${book['remaining_days']}',
                          '$remainingDays',
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffFF693D)),
                        ),
                        Text(
                          'days',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffFF693D)),
                        ),
                        // Text(
                        //   'left',
                        //   style: TextStyle(fontSize: 10, color: Color(0xffFF693D)),
                        // ),
                      ] else ...[
                        Text(
                          'Fine : ${book['fine_amount']}',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xffFF693D)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          book['isPaid'] ? 'Paid' : 'Due',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                (book['isPaid']) ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
