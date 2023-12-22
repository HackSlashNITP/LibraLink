import 'package:flutter/material.dart';

import  'package:libralink/home_screen.dart';
class IssuedBookModel{
  final int bookId;
  final String IssuedDate;
  final String ReturnDate;
  final String authorName;
  final String bookName;
  final bool isSubmitted;
  const IssuedBookModel({
    required this.bookId,
    required this.IssuedDate,
    required this.ReturnDate,
    required this.isSubmitted,
    required this.bookName,
    required this.authorName,
  });


}
 


