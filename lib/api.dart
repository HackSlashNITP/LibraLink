import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libralink/books%20model/issuedbook_model.dart';
import 'package:libralink/books%20model/privious_issuedbook_model.dart';

class APIs {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getIssuedBooks() {
    // return firestore.collection('issued_books').snapshots();
    User? CurrentUser= _auth.currentUser!;


    return firestore.collection('user').doc(CurrentUser.uid).collection('Account').snapshots();
    // return firestore.collection('issued_books').docs('uuid').collection('Transaction').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getPriviousIssuedBooks() {
    // return firestore.collection('privious_books').snapshots();
    return firestore.collection('user').doc('user').collection('Account').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserdetails() {
    return firestore.collection('user').snapshots();
  }

  // add To issue book functionlity implemented here

  // static Future<void> addBooks() async {
  //   final book = IssuedBook(issuedDate: issuedDate, author: author, bookId: bookId, title: title, remainingDays: remainingDays, returnDate: returnDate)
  //   return (await firestore
  //       .collection('issued_books')
  //       .doc(book.bookId.toString())
  //       .set(book.toJson()));
  // }

  //    // add To privious issue book functionlity implemented here

  // static Future<void> addPriviousBooks() async {
  //   final pbook=PriviousIssueBook(isPaid: isPaid, issuedDate: issuedDate, author: author, lateDays: lateDays, fineAmount: fineAmount, title: title, returned: returned)
  //   return (await firestore
  //       .collection('privious_books')
  //       .doc(pbook.bookId.toString())
  //       .set(pbook.toJson()));
  // }
}
