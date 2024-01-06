import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libralink/noDuesScreen.dart';

import '../duesScreen.dart';

class LateFee extends StatelessWidget {
  const LateFee({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: calculateTotalLateFees(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          int totalLateFees = snapshot.data ?? 0;
          if (totalLateFees == 0) {
            // Navigate to NoDuePage if totalLateFees is zero
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => noDues()),
              );
            });

            // Return an empty container for now, as we have navigated to another page
            return Container();
          } else {
            return Text(
              '₹$totalLateFees',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          }
        }
      },
    );
  }
}

Future<int> calculateTotalLateFees() async {
  int totalLateFees = 0;

  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('issued_books').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String issuedDate = doc['issued_date'];
      String returnDate = doc['return_date'];

      DateFormat dateFormat = DateFormat('dd-MM-yyyy');
      DateTime issuedDateTime = dateFormat.parse(issuedDate);
      DateTime returnDateTime = dateFormat.parse(returnDate);

      int daysDelayed = returnDateTime.difference(issuedDateTime).inDays - 14;
      if (daysDelayed > 0) {
        totalLateFees += daysDelayed;
      }
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
  return totalLateFees;
}
