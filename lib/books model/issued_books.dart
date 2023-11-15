import 'dart:core';
import 'package:intl/intl.dart';
final DateFormat formatter = DateFormat('dd-MMM-yyyy');

class Item{
  final String url;
  final String title;
  final String author;
  final String issuedate;
  final String returndate;
  final int days;


  Item({required this.url,required this.title,required this.issuedate,required this.returndate,required this.author,required this.days});

}
List<Item> items= [
  Item(url: 'assets/images/Group (1).png',title: 'Engineering Physics', issuedate: formatter.format(DateTime(2023, 11, 16)), returndate: formatter.format(DateTime(2023, 11, 29)),
  days:3,author: 'H.C. Verma'),
  Item(url: 'assets/images/Group (1).png',title: 'Theory Of Everything',
      issuedate: formatter.format(DateTime(2023, 11, 18)), returndate: formatter.format(DateTime(2023, 12, 15)),
      days:13,author: 'Stephens Hawking'),
  Item(url: 'assets/images/Group (1).png',title: 'Theory Of Everything',
      issuedate: formatter.format(DateTime(2023, 11, 18)), returndate: formatter.format(DateTime(2023, 12, 15)),
      days:23,author: 'Stephens Hawking'),
  Item(url: 'assets/images/Group (1).png',title: 'Theory Of Everything',
      issuedate: formatter.format(DateTime(2023, 11, 18)), returndate: formatter.format(DateTime(2023, 12, 15)),
      days:33,author: 'Stephens Hawking'),
];