import 'package:flutter/material.dart';

class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  final idController = TextEditingController();
  final issueController = TextEditingController();
  final nameController = TextEditingController();
  final duecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    issueController.dispose();
    nameController.dispose();
    duecontroller.dispose();
  }

  Future<void> issuedate() async {
    DateTime? picked = await showDatePicker(
        context: this.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        issueController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> duetdate() async {
    DateTime? picked = await showDatePicker(
        context: this.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        duecontroller.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 25,
        ),
        title: Text(
          "Add Books",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: ' Book Name ',
                labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF0A043C),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: 'Book Id',
                labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF0A043C),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: TextField(
              readOnly: true,
              controller: issueController,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
                labelText: 'Isuued Date',
                labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF0A043C),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onTap: () {
                issuedate();
              },
            ),
          ),
          TextField(
            readOnly: true,
            controller: duecontroller,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              labelText: 'Submission Date',
              labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF0A043C),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onTap: () {
              duetdate();
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                'Add Book ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ]),
      ),
    );
  }
}
