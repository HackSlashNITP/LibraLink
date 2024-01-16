import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:libralink/api.dart';

class ReIssueContent extends StatefulWidget {
  const ReIssueContent({Key? key}) : super(key: key);
  @override
  _ReIssueContentState createState() => _ReIssueContentState();
}

class _ReIssueContentState extends State<ReIssueContent> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static User? CurrentUser;

  @override
  initState() {
    super.initState();

    CurrentUser = auth.currentUser!;
  }

  Future<void> renewBook(id, returnDate, remainingDays) async {
    DateTime oldReturnDate = DateFormat('yyyy-MM-dd').parse(returnDate);
    DateTime newReturnDate = oldReturnDate.add(Duration(days: 14));
    String newFormattedDate = DateFormat('yyyy-MM-dd').format(newReturnDate);
    int oldRemainingDays = remainingDays;
    int newRemainingDays = oldRemainingDays + 14;

    await FirebaseFirestore.instance
        .collection('user')
        .doc(CurrentUser!.uid)
        .collection('Account')
        .doc(id)
        .update({
      'returndate': newFormattedDate,
      'remaining_days': newRemainingDays,
    });
  }

  Future<void> returnBook(id) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(CurrentUser!.uid)
        .collection('Account')
        .doc(id)
        .update({'isReturned': true});
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Access the 'book' parameter
    // final dynamic book = arguments['book'];

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Re-issue page',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(CurrentUser!.uid)
                    .collection('Account')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  // Assuming 'book_id' is a unique identifier for each book
                  var book = documents.firstWhere(
                    (doc) => doc['book_id'] == arguments['book']['book_id'],
                  );

                  if (book == null || book['isReturned']) {
                    return Center(
                      child: Text('Book not found or already returned.'),
                    );
                  }

                  DateTime issuedDate = DateTime.parse(book['issued_date']);
                  DateTime returnDate = DateTime.parse(book['returndate']);
                  int remainingDays = returnDate.difference(issuedDate).inDays;

                  return Container(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 120, 53, 6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                'Book Name: ${book['title']}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Author Name: ${book['author']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 60),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.width *
                                  0.8 *
                                  310 /
                                  315,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Issue Date:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '${book['issued_date']}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Return Date:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '${book['returndate']}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Remaining Days:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '${remainingDays}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          returnBook(book['book_id']);
                                          setState(() {});
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Return',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await renewBook(
                                              book['book_id'],
                                              book['returndate'],
                                              remainingDays);

                                          setState(() {});
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Renew',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  return Container();
                })));
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:libralink/api.dart';

// class ReIssueContent extends StatefulWidget {
//   final book;
//   const ReIssueContent({Key? key, this.book}) : super(key: key);
//   @override
//   _ReIssueContentState createState() => _ReIssueContentState();
// }

// class _ReIssueContentState extends State<ReIssueContent> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   static User? CurrentUser;

//   @override
//   initState() {
//     super.initState();

//     CurrentUser = auth.currentUser!;
//   }

//   Future<void> renewBook(id, returnDate, remainingDays) async {
//     DateTime oldReturnDate = DateFormat('yyyy-MM-dd').parse(returnDate);
//     DateTime newReturnDate = oldReturnDate.add(Duration(days: 14));
//     String newFormattedDate = DateFormat('yyyy-MM-dd').format(newReturnDate);
//     int oldRemainingDays = remainingDays;
//     int newRemainingDays = oldRemainingDays + 14;

//     await FirebaseFirestore.instance
//         .collection('user')
//         .doc(CurrentUser!.uid)
//         .collection('Account')
//         .doc(id)
//         .update({
//       'returndate': newFormattedDate,
//       'remaining_days': newRemainingDays,
//     });
//   }

//   Future<void> returnBook(id) async {
//     await FirebaseFirestore.instance
//         .collection('user')
//         .doc(CurrentUser!.uid)
//         .collection('Account')
//         .doc(id)
//         .update({'isReturned': true});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             title: Text(
//               'Re-issue page',
//               style: TextStyle(color: Colors.black),
//             ),
//             centerTitle: true,
//           ),
//           body: StreamBuilder(
//             stream: APIs.getIssuedBooks(),
//             builder: (context,
//                 AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     padding: EdgeInsets.all(0),
//                     itemCount: 1,
//                     itemBuilder: (context, index) {
//                       // var book = snapshot.data!.docs[index].data();

//                       DateTime issuedDate =
//                           DateTime.parse(book['issued_date']);
//                       DateTime returnDate =
//                           DateTime.parse(book['returndate']);
//                       int remainingDays =
//                           returnDate.difference(issuedDate).inDays;

//                       return book['isReturned'] == false
//                           ? Container(
//                               child: Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(16.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.3,
//                                         height:
//                                             MediaQuery.of(context).size.width *
//                                                 0.3,
//                                         decoration: BoxDecoration(
//                                           color:
//                                               Color.fromARGB(255, 120, 53, 6),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                       ),
//                                       SizedBox(height: 20),
//                                       Center(
//                                         child: Text(
//                                           'Book Name: ${book['title']}',
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Center(
//                                         child: Text(
//                                           'Author Name: ${book['author']}',
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                       ),
//                                       SizedBox(height: 60),
//                                       Container(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.8,
//                                         height:
//                                             MediaQuery.of(context).size.width *
//                                                 0.8 *
//                                                 310 /
//                                                 315,
//                                         margin: EdgeInsets.symmetric(
//                                             horizontal: 20),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 15),
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey[200],
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   'Issue Date:',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                                 Text(
//                                                   '${book['issued_date']}',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   'Return Date:',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                                 Text(
//                                                   '${book['returndate']}',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   'Remaining Days:',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                                 Text(
//                                                   '${remainingDays}',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: 20),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     returnBook(
//                                                         book['book_id']);
//                                                   },
//                                                   style:
//                                                       ElevatedButton.styleFrom(
//                                                     primary: Colors.black,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               8.0),
//                                                     ),
//                                                   ),
//                                                   child: Text(
//                                                     'Return',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                                 ElevatedButton(
//                                                   onPressed: () async {
//                                                     await renewBook(
//                                                         book['book_id'],
//                                                         widget
//                                                             .book['returndate'],
//                                                         remainingDays);

//                                                     setState(() {});
//                                                   },
//                                                   style:
//                                                       ElevatedButton.styleFrom(
//                                                     primary: Colors.black,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               8.0),
//                                                     ),
//                                                   ),
//                                                   child: Text(
//                                                     'Renew',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : null;
//                     });
//               }
//               return CircularProgressIndicator();
//             },
//           )),
//     );
//   }
// }
