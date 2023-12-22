import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; 

class IssuedBookModel {
  final String bookId;
  final String issuedDate;
  String returnDate;
  final bool isSubmitted;
  final String bookName;
  final String authorName;
  final String activeDue; 

  IssuedBookModel({
    required this.bookId,
    required this.issuedDate,
    required this.returnDate,
    required this.isSubmitted,
    required this.bookName,
    required this.authorName,
    required this.activeDue, 
  });
}

class ReIssueContent extends StatefulWidget {
  @override
  _ReIssueContentState createState() => _ReIssueContentState();
}

class _ReIssueContentState extends State<ReIssueContent> {
  late Stream<DocumentSnapshot> userStream;
  int currentBookIndex = 0;

  @override
  void initState() {
    super.initState();
    userStream = FirebaseFirestore.instance.collection("UserData").doc("1").snapshots();
  }

// Future<void> renewBook() async {
//   final userDataSnapshot = await FirebaseFirestore.instance.collection("UserData").doc("1").get();
//   final userData = userDataSnapshot.data();

//   if (userData != null && userData is Map<String, dynamic>) {
//     final issuedBooks = userData["IssuedBook"];
//     if (issuedBooks != null && issuedBooks is List<dynamic>) {
//       final List<dynamic> updatedBooks = List.from(issuedBooks); 

//       String oldReturnDateString = updatedBooks[currentBookIndex]['ReturnDate'];
//       DateTime oldReturnDate = DateFormat('dd/MM/yyyy').parse(oldReturnDateString);

//       DateTime newReturnDate = oldReturnDate.add(Duration(days: 14));

//       String newReturnDateString = DateFormat('dd/MM/yyyy').format(newReturnDate);
//       Map<String, dynamic> bookToUpdate = updatedBooks[currentBookIndex];
//       bookToUpdate['ReturnDate'] = newReturnDateString;
//       updatedBooks[currentBookIndex] = bookToUpdate;

//       await FirebaseFirestore.instance.collection("UserData").doc("1").update({"IssuedBook": updatedBooks});
//       setState(() {});
//     }
//   }
// }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
           return Scaffold(
            body: Center(
              child: Text("Page Not Found"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ),
          );
        }

        final Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;

        String activeDue = data != null && data['Dues'] != null
            ? data['Dues'].toString()
            : '00'; // Fetch activeDue

        final dynamic issuedBooks = data != null ? data["IssuedBook"] : null;

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
          body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0 && currentBookIndex > 0) {
                setState(() {
                  currentBookIndex--;
                });
              } else if (details.primaryVelocity! < 0 && currentBookIndex < (issuedBooks?.length ?? 0) - 1) {
                setState(() {
                  currentBookIndex++;
                });
              }
            },
            child: Container(
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
                          'Book Name: ${issuedBooks != null ? issuedBooks['$currentBookIndex']['bookName'] : 'N/A'}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Author Name: ${issuedBooks != null ? issuedBooks['$currentBookIndex']['authorName'] : 'N/A'}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 60),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8 * 310 / 315,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${issuedBooks != null ? issuedBooks['$currentBookIndex']['IssuedDate'] : 'N/A'}',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Return Date:',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${issuedBooks != null ? issuedBooks['$currentBookIndex']['ReturnDate'] : 'N/A'}',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Active Due:',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${issuedBooks != null ? issuedBooks['$currentBookIndex']['activeDue'] : 'N/A'}',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Logic 
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
                                    // await renewBook();
                                    // setState(() {});
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
          ),
        );
      },
    );
  }
}
