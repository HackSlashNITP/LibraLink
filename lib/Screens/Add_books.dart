import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libralink/DB-models/account.dart' as model;
import 'package:libralink/api.dart';

class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  final idController = TextEditingController();
  final issueController = TextEditingController();
  final nameController = TextEditingController();
  final duecontroller = TextEditingController();
  final authorcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    issueController.dispose();
    nameController.dispose();
    duecontroller.dispose();
    authorcontroller.dispose();
  }

  Future<void> issuedate() async {
    DateTime? picked = await showDatePicker(
        context: this.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        issueController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> duetdate() async {
    DateTime? picked = await showDatePicker(
        context: this.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        duecontroller.text = picked.toString().split(' ')[0];
      });
    }
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    void addbooks() async {
      CollectionReference user = await _firestore.collection('user');
      try {
        model.Account account = model.Account(
            isReturned: false,
            issuedDate: issueController.text,
            author: authorcontroller.text,
            fineAmount: 0,
            bookId: idController.text,
            returndate: duecontroller.text,
            title: nameController.text,
            isPaid: false);
        await _firestore
            .collection('user')
            .doc(_auth.currentUser!.uid)
            .collection('Account')
            .doc(idController.text)
            .set(account.tojson());
        String name = nameController.text;
        showToast("$name Book added Successfully");
      } catch (e) {
        _showErrorDialog("Error during adding: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 25,
        ),
        title: Text(
          "Add Books",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: ' Book Name ',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0A043C),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: authorcontroller,
                  decoration: InputDecoration(
                    labelText: ' Author ',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0A043C),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'Book Id',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0A043C),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                  readOnly: true,
                  controller: issueController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: 'Isuued Date',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0A043C),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onTap: () {
                    issuedate();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  readOnly: true,
                  controller: duecontroller,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: 'Submission Date',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0A043C),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onTap: () {
                    duetdate();
                  },
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E293B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Add Book ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    addbooks();
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
