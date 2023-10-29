import 'package:flutter/material.dart';

class DuesScreen extends StatefulWidget {
  const DuesScreen({super.key});

  @override
  State<DuesScreen> createState() => _DuesScreenState();
}

class Book {
  String name;
  DateTime dateIssued;
  int daysIssued;
  Book(this.name, this.dateIssued, this.daysIssued);
}

class _DuesScreenState extends State<DuesScreen> {
  @override
  int _counter = 55;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Dues",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Center(
          child: Column(children: [
            SizedBox(height: 20),
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(width: 6.0, color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Rs $_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Dues Pending",
              style: TextStyle(
                color: Colors.blueGrey[700],
                fontWeight: FontWeight.w500,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 100),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Flexible(
                child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: new BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                '${books[index].name}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                  '${books[index].dateIssued.toString().substring(0, 10)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              Text('${books[index].daysIssued}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 50, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        textStyle: TextStyle(fontSize: 15),
                        primary: Colors.blueGrey,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: Text(
                      'Pay Dues',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        textStyle: TextStyle(fontSize: 15),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: Text(
                      'Payment History',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

List<Book> books = [
  Book("Book1", DateTime(2023, 10, 1), 10),
  Book("Book2", DateTime(2023, 10, 2), 23),
  Book("Book3", DateTime(2023, 10, 5), 13),
  Book("Book4", DateTime(2023, 10, 6), 15),
];
