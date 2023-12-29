class PriviousIssueBook {
  PriviousIssueBook({
    required this.isPaid,
    required this.issuedDate,
    required this.author,
    required this.lateDays,
    required this.fineAmount,
    required this.bookId,
    required this.returned,
    required this.title,
  });
  late final bool isPaid;
  late final String issuedDate;
  late final String author;
  late final int lateDays;
  late final int fineAmount;
  late final int bookId;
  late final String returned;
  late final String title;

  PriviousIssueBook.fromJson(Map<String, dynamic> json) {
    isPaid = json['isPaid'];
    issuedDate = json['issued_date'];
    author = json['author'];
    lateDays = json['late_days'];
    fineAmount = json['fine_amount'];
    bookId = json['book_id'];
    returned = json['returned'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPaid'] = isPaid;
    data['issued_date'] = issuedDate;
    data['author'] = author;
    data['late_days'] = lateDays;
    data['fine_amount'] = fineAmount;
    data['book_id'] = bookId;
    data['returned'] = returned;
    data['title'] = title;
    return data;
  }
}
