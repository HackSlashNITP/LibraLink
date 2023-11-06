class lib {
  final String name;
  final String date;
  final int time;

  lib({required this.name, required this.date, required this.time});
}

class libmodel {
  static final books = [
    lib(name: "The Subtle art of not giving a fu*k", date: "15 dec", time: 1),
    lib(name: "Rich Dad Poor dad", date: "7 dec", time: 3),
    lib(name: "Think & grow rich", date: "20 dec", time: 7)
  ];
}
