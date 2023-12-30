import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReIssueContent extends StatefulWidget {
  @override
  _ReIssueContentState createState() => _ReIssueContentState();
}

class _ReIssueContentState extends State<ReIssueContent> {
  late Stream<QuerySnapshot> bookStream;
  int currentBookIndex = 0;

  @override
  void initState() {
    super.initState();
    bookStream =
        FirebaseFirestore.instance.collection("issued_books").snapshots();
  }

  CollectionReference issued_books =
      FirebaseFirestore.instance.collection('issued_books');
  Future<void> deletebook(id) {
    print("Book Deleted id: $id");
    print(currentBookIndex);
    return issued_books
        .doc(id)
        .delete()
        .then((value) => print('Book Deleted'))
        .catchError((error) => print('Failed to Delete Book: $error'));
  }

  Future<void> renewBook(id, returnDate, remainingDays) async {
    DateTime oldReturnDate = DateFormat('dd-MM-yyyy').parse(returnDate);
    DateTime newReturnDate = oldReturnDate.add(Duration(days: 14));
    String newFormattedDate = DateFormat('dd-MM-yyyy').format(newReturnDate);
    int oldRemainingDays = remainingDays;
    int newRemainingDays = oldRemainingDays + 14;

    await issued_books.doc(id).update({
      'return_date': newFormattedDate,
      'remaining_days': newRemainingDays,
    });
    print('Book Renewed');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: bookStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
        }).toList();

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
              } else if (details.primaryVelocity! < 0 &&
                  currentBookIndex < (storedocs?.length ?? 0) - 1) {
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
                          'Book Name: ${storedocs != null ? storedocs[currentBookIndex]['title'] : 'N/A'}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Author Name: ${storedocs != null ? storedocs[currentBookIndex]['author'] : 'N/A'}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 60),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height:
                            MediaQuery.of(context).size.width * 0.8 * 310 / 315,
                        margin: EdgeInsets.symmetric(horizontal: 20),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${storedocs != null ? storedocs[currentBookIndex]['issued_date'] : 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Return Date:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${storedocs != null ? storedocs[currentBookIndex]['return_date'] : 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remaining Days:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${storedocs != null ? storedocs[currentBookIndex]['remaining_days'] : 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => {
                                    deletebook(
                                        storedocs[currentBookIndex]['id']),
                                    setState(() {
                                      storedocs.removeAt(currentBookIndex);
                                      if (currentBookIndex >=
                                              storedocs.length &&
                                          storedocs.length > 0) {
                                        currentBookIndex = storedocs.length - 1;
                                      }
                                    })
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
                                    await renewBook(
                                      storedocs[currentBookIndex]['id'],
                                      storedocs[currentBookIndex]
                                          ['return_date'],
                                      storedocs[currentBookIndex]
                                          ['remaining_days'],
                                    );
                                    setState(() {});
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
