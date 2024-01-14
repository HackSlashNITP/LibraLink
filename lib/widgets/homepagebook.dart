import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libralink/api.dart';
import 'package:libralink/api.dart';
import 'package:libralink/books%20model/issuedBookHomePage.dart';
import 'package:libralink/books%20model/homePage.dart';
import 'package:libralink/duesScreen.dart';

class MyListViewBuilder extends StatefulWidget {
  final List<IssuedBookModel> booklist;
  MyListViewBuilder({Key? key, required this.booklist}) : super(key: key);

  @override
  State<MyListViewBuilder> createState() => _MyListViewBuilderState();
}

class _MyListViewBuilderState extends State<MyListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.booklist.length == 0
        ? Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "No book Due",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: widget.booklist.length,
            itemBuilder: (context, index) {
              if (widget.booklist[index].isSubmitted == false)
                return MyListItem(
                    title: widget.booklist[index].bookName,
                    date: widget.booklist[index].ReturnDate,
                    imagePath: 'assets/images/Group (1).png');
              else
                return Container();
            });
  }
}

class MyListItem extends StatelessWidget {
  final String title;
  final String date;
  final String imagePath;

  MyListItem(
      {required this.title, required this.date, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(top: 10), // Remove space
      elevation: 0.0,
      color: Color.fromARGB(255, 235, 233, 233),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          SizedBox(
              child: Icon(
            Icons.circle_outlined,
            color: Color(0xff64748B),
            size: 25,
          )),
          Spacer(flex: 1),
          Container(
            alignment: Alignment.centerLeft,
            // color: Colors.amber,
            padding: EdgeInsets.only(top: 10),
            // width: screenSize.width * 0.3,
            height: screenSize.height * 0.09,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 0,
                    left: 0,
                  ),
                  child: Text(
                    this.date,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0, left: 0, top: 5),
                  child: Text(
                    this.title,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: screenSize.width * 0.15),

          Spacer(flex: 4),
          // Right side with the image
          Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                imagePath,
                width: 42,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Spacer(flex: 1)
        ],
      ),
    );
  }
}
