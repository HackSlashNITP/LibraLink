
import 'dart:core';
import 'package:intl/intl.dart';
final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
class HomePageBook{
  final String url;
  final String title;
  final String date;



  HomePageBook({required this.url,required this.title,required this.date,});

}
List<HomePageBook> items= [
HomePageBook(url: 'assets/images/Rectorange.png',title: 'The Subtle art of not giving a Fuck', date: formatter.format(DateTime(2023, 11, 16)),
),
HomePageBook(url: 'assets/images/Rectpurple.png',title: 'Rich Dad Poor Dad ',
date: formatter.format(DateTime(2023, 11, 20)),),
HomePageBook(url: 'assets/images/Rectpurple.png',title: 'Think and Grow Rich',
date: formatter.format(DateTime(2023, 11, 29)), )];