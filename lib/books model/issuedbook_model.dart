class IssuedBook {
  IssuedBook({
    required this.issuedDate,
    required this.author,
    required this.bookId,
    required this.title,
    required this.remainingDays,
    required this.returnDate,
  });
  late final String issuedDate;
  late final String author;
  late final int bookId;
  late final String title;
  late final int remainingDays;
  late final String returnDate;
  
  IssuedBook.fromJson(Map<String, dynamic> json){
    issuedDate = json['issued_date'];
    author = json['author'];
    bookId = json['book_id'];
    title = json['title'];
    remainingDays = json['remaining_days'];
    returnDate = json['return_date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['issued_date'] = issuedDate;
    data['author'] = author;
    data['book_id'] = bookId;
    data['title'] = title;
    data['remaining_days'] = remainingDays;
    data['return_date'] = returnDate;
    return data;
  }
}