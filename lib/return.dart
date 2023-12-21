import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IssuedBookModel {
  final String bookId;
  final String IssuedDate;
  String ReturnDate;
  final bool isSubmitted;
  final String bookName;
  final String authorName;
  final String activeDue; // New field added

  IssuedBookModel({
    required this.bookId,
    required this.IssuedDate,
    required this.ReturnDate,
    required this.isSubmitted,
    required this.bookName,
    required this.authorName,
    required this.activeDue, // New field added
  });
}

class ReIssueContent extends StatefulWidget {
  @override
  _ReIssueContentState createState() => _ReIssueContentState();
}

class _ReIssueContentState extends State<ReIssueContent> {
  late Stream<QuerySnapshot> userStream;

  @override
  void initState() {
    super.initState();
    userStream = FirebaseFirestore.instance.collection("UserData").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ),
          );
        }

        final List<Map<String, dynamic>> docData = snapshot.data!.docs
            .map((e) => e.data() as Map<String, dynamic>)
            .toList();

        List<IssuedBookModel> booksinUser = [];
        final dynamic data = docData.isNotEmpty ? docData[0] : null;
        final List? issuedBooks = data != null ? data["IssuedBook"] : null;

        final String activeDue = data != null && data['Dues'] != null
            ? data['Dues'].toString()
            : 'Some Value'; // Fetch activeDue

        if (issuedBooks != null) {
          for (int i = 0; i < issuedBooks.length; i++) {
            booksinUser.add(
              IssuedBookModel(
                bookId: issuedBooks[i]['bookId'].toString() ?? '',
                IssuedDate: issuedBooks[i]['IssuedDate'].toString() ?? '',
                ReturnDate: issuedBooks[i]['ReturnDate'].toString() ?? '',
                isSubmitted: issuedBooks[i]['isSubmitted'] ?? false,
                bookName: issuedBooks[i]['bookName'].toString() ?? '',
                authorName: issuedBooks[i]['authorName'].toString() ?? '',
                activeDue:
                    activeDue, // Set activeDue for all books to the same value from 'Dues'
              ),
            );
          }
        }

        return Scaffold(
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
          body: Container(
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
                      ), // Change the color to blue
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        booksinUser.isNotEmpty
                            ? booksinUser[0].bookName
                            : 'Book Name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        booksinUser.isNotEmpty
                            ? booksinUser[0].authorName
                            : 'Author Name',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Spacer(flex: 2,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height:
                          MediaQuery.of(context).size.width * 0.8 * 310 / 315,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Issue Date:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '${booksinUser.isNotEmpty ? booksinUser[0].IssuedDate : 'Some Date Value'}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Return Date:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '${booksinUser.isNotEmpty ? booksinUser[0].ReturnDate : 'Some Date Value'}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Active Due:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '${booksinUser.isNotEmpty ? booksinUser[0].activeDue : 'Some Value'}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          // Other fields...
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Logic for Return button
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Return',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              
                              ElevatedButton(
                                onPressed: () async {
    // if (booksinUser.isNotEmpty) {
    //   String originalReturnDateString = booksinUser[0].ReturnDate;
    //   List<String> dateParts = originalReturnDateString.split('/');
      
    //   if (dateParts.length == 3) {
    //     int day = int.tryParse(dateParts[0]) ?? 0;
    //     int month = int.tryParse(dateParts[1]) ?? 0;
    //     int year = int.tryParse(dateParts[2]) ?? 0;
        
    //     if (day != 0 && month != 0 && year != 0) {
    //       DateTime originalReturnDate = DateTime(year, month, day);
    //       DateTime newReturnDate = originalReturnDate.add(Duration(days: 14));
          
    //       String newReturnDateString =
    //           "${newReturnDate.day}/${newReturnDate.month}/${newReturnDate.year}";
          
    //       // Update Firebase Firestore
    //       await FirebaseFirestore.instance
    //           .collection('UserData')
    //           .doc('0')
    //           .update({'IssuedBook.0.ReturnDate': newReturnDateString});

    //       // Update local data (assuming booksinUser[0] is the book being updated)
    //       setState(() {
    //         booksinUser[0].ReturnDate = newReturnDateString;
    //       });
    //     }
    //   }
    // }
  },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
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
          ),
        );
      },
    );
  }
}
