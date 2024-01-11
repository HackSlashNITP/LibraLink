
class IssuedBookModel{
  final int bookId;
  final String IssuedDate;
  final String ReturnDate;
  final String authorName;
  final String bookName;
  final int activeDue;
  final bool isSubmitted;

  const IssuedBookModel({
    required this.bookId,
    required this.IssuedDate,
    required this.ReturnDate,
    required this.isSubmitted,
    required this.bookName,
    required this.authorName, 
    required this.activeDue, 
  });


}
 


