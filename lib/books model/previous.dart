import 'dart:core';
import 'package:intl/intl.dart';
final DateFormat formatter = DateFormat('dd-MMM-yyyy');

class Previous_Book{
  final String url;
  final String title;
  final String author;
  final String issuedate;
  final String returndate;
  final int days;
  String dues;
  final int? fine;


  Previous_Book({required this.url,this.fine, required this.title,required this.issuedate,required this.returndate,required this.author,required this.days,required this.dues});

}
List<Previous_Book> prevbooks= [

  Previous_Book(url: 'assets/images/Group (1).png',title: 'Theory Of Everything',
      issuedate: formatter.format(DateTime(2023, 11, 18)), returndate: formatter.format(DateTime(2023, 12, 25)),
      days:23,author: 'Stephens Hawking',dues: "Paid",fine: 50),
  Previous_Book(url: 'assets/images/Group (1).png',title: 'Theory Of Everything',
      issuedate: formatter.format(DateTime(2023, 11, 18)), returndate: formatter.format(DateTime(2023, 12, 15)),
      days:33,author: 'Stephens Hawking',fine:50,dues: "Due"),
];