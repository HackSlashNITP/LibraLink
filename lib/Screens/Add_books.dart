import 'package:flutter/material.dart';

class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  final idController = TextEditingController();
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final cpasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    dateController.dispose();
    nameController.dispose();
    cpasswordController.dispose();
  }

  Future<void> selectdate() async {
    DateTime? picked = await showDatePicker(
        context: this.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(' ')[0];
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
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(30)),
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
              controller: dateController,
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
                selectdate();
              },
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 30),
          //   child: TextField(
          //     controller: cpasswordController,
          //     obscureText: true,
          //     decoration: InputDecoration(
          //       labelText: ' Confirm Password ',
          //       labelStyle: TextStyle(color: Color.fromARGB(255, 8, 1, 21)),
          //       enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.black87),
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: Color(0xFF0A043C),
          //         ),
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //     onTap: () {
          //       selectdate();
          //     },
          //   ),
          // ),
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
