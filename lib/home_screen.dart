import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libralink/books%20model/issuedBookHomePage.dart';
import 'package:libralink/routes/mapping.dart';
import 'package:libralink/widgets/homepagebook.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection("UserData").snapshots();

  final Stream<DocumentSnapshot> _documentStream =
      FirebaseFirestore.instance.collection('UsersData').doc('0').snapshots();

  late Stream<Map<String, dynamic>> documentStream =
      getDocumentStream("UserData", "0");
  // ** created a function which fetches only a specific doc from the
  // **   collection and stored in documentStream
  Stream<Map<String, dynamic>> getDocumentStream(
      String collectionName, String documentId) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.data() ?? {};
    });
  }

  //  CollectionReference students =
  //   FirebaseFirestore.instance.collection("UserData");

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return StreamBuilder<Map<String, dynamic>>(
        stream: documentStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ));
          }

          //** Mapped the snapshot data and stored in documentData */

          Map<String, dynamic> documentData = snapshot.data ?? {};
          //** Take out the IssuedBook Map  */
          Map<String, dynamic> issuedBooks = documentData['IssuedBook'];
          List<Map<String, dynamic>> issuedBooksList = [];
          //** Here for all the keys of Issued book, I take the Map and stored in issuedBooksList */
          int i = 0;
          while (issuedBooks["$i"] != null) {
            issuedBooksList.add(issuedBooks["$i"]!);
            // print(issuedBooks["$i"]);
            i++;
          }

          // print(issuedBooksList);
          //** finally created an object list of IssuedBooksModel which i pass to
          //    widget  called MyListViewBuilder*/
          List<IssuedBookModel> booksinUser = [];
          for (int j = 0; j < issuedBooksList.length; j++) {
            booksinUser.add(IssuedBookModel(
              bookId: issuedBooksList[j]['bookId'],
              IssuedDate: issuedBooksList[j]['IssuedDate'],
              ReturnDate: issuedBooksList[j]['ReturnDate'],
              isSubmitted: issuedBooksList[j]['isSubmitted'],
              bookName: issuedBooksList[j]['bookName'],
              authorName: issuedBooksList[j]['authorName'],
              activeDue: issuedBooksList[j]['activeDue'],
            ));
          }
          return Scaffold(
              body: Container(
            width: screenSize.width,
            color: Color.fromARGB(255, 255, 255, 255),
            child: Stack(children: [
              Container(
                  width: screenSize.width,
                  height: 410,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/bgimg.png"),
                    fit: BoxFit.fill,
                  )),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50.0, left: 19, right: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.profileRoute);
                          },
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset('assets/images/Group 34.png')),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.notifRoute);
                          },
                          child: Container(
                              height: 30,
                              width: 33,
                              child: Image.asset('assets/images/Vector.png')),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 50, right: 100),
                child: Container(
                  width: 425,
                  height: 123,
                  alignment: Alignment.center,
                  child: Text("WELCOME🤚",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 130, left: 38),
                child: Container(
                  child: Text(
                    documentData["Username"],
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 254, 254, 254)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 200),
                child: Container(
                  width: 265,
                  height: 40,
                  child: TextField(
                    controller: myController,
                    autofocus: false,
                    //autofocus: false,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        isCollapsed: false,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: const Color.fromARGB(255, 0, 0, 0),
                        fillColor: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200, left: 300),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Container(
                    child: GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/images/Group 37.png')),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 300),
                child: Container(
                  width: 524,
                  height: 520,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 233, 233),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Padding(
                      padding: EdgeInsets.only(right: 160),
                      child: Column(
                        children: [
                          Text(
                            'Features',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 380, left: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: 50,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/issued_book.dart");
                                  },
                                  child:
                                      Image.asset('assets/images/book.png'))),
                          Text('Issued'),
                          Text('Books')
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: 50,
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                      'assets/images/locateBook.png'))),
                          Text('Locate'),
                          Text('Books')
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: 50,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/duesScreen.dart");
                                  },
                                  child: Image.asset(
                                      'assets/images/libdues.png'))),
                          Text('Library'),
                          Text('Dues')
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MyRoutes.addbooks);
                                },
                                child: Icon(
                                  Icons.add_circle_outlined,
                                  size: 42,
                                  color: Color.fromARGB(178, 32, 39, 78),
                                ),
                              )),
                          Text('Add'),
                          Text('Books')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 480, left: 30, right: 10),
                child: Row(
                  children: [
                    Text(
                      'Deadlines',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.asset('assets/images/line.png'),
                    ),
                  ],
                ),
              ),
              //**jay's hard coded values */
              // Padding(
              //   padding: const EdgeInsets.only(top: 533, left: 28),
              //   child:
              //       Icon(Icons.circle, color: Color.fromARGB(255, 85, 85, 85)),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 608, left: 28),
              //   child: Icon(Icons.circle_outlined,
              //       color: Color.fromARGB(255, 35, 35, 35)),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 685, left: 28),
              //   child: Icon(Icons.circle_outlined,
              //       color: Color.fromARGB(255, 0, 0, 0)),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 554, left: 29),
              //   child: SizedBox(
              //       width: 20,
              //       height: 55,
              //       child: Image.asset('assets/images/Vector 11.png')),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 630, left: 29),
              //   child: SizedBox(
              //       width: 20,
              //       height: 55,
              //       child: Image.asset('assets/images/Vector 11.png')),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 520, left: 10),
                child: SizedBox(
                  child: MyListViewBuilder(booklist: booksinUser),
                ),
              )
            ]),
          ));
        });
  }
}
