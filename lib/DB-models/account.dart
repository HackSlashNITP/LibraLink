class Account {
  Account(
      {required this.isReturned,
      required this.issuedDate,
      required this.author,
      required this.fineAmount,
      required this.bookId,
      required this.returndate,
      required this.title,
      required this.isPaid});

  final bool isReturned;
  final bool isPaid;
  final String issuedDate;
  final String author;
  final int fineAmount;
  final String bookId;
  final String returndate;
  final String title;

  Map<String, dynamic> tojson() {
    final data = <String, dynamic>{};
    data['isReturned'] = isReturned;
    data['issued_date'] = issuedDate;
    data['author'] = author;
    data['isPaid'] = isPaid;
    data['fine_amount'] = fineAmount;
    data['book_id'] = bookId;
    data['returndate'] = returndate;
    data['title'] = title;
    return data;
  }
}
