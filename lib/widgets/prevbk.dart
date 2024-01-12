// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:libralink/api.dart';
// import 'package:libralink/books%20model/issuedbook_model.dart';
// import 'package:libralink/books%20model/privious_issuedbook_model.dart';
// import 'package:libralink/widgets/bookItem.dart';
// import '../books model/previous.dart';

// class PreviousBookPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: APIs.getIssuedBooks(),
//       builder: (context,
//           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//               padding: EdgeInsets.all(0),
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (context, index) {
//                 var user_data = snapshot.data!.docs[index].data();
//                 if (user_data['isReturned'] == true)
//                   return buildBookItem(book: user_data);
//                 else
//                   return Container();
//               });
//         }
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }

// Widget _buildPreviousBookItem(PriviousIssueBook bk, BuildContext context) {
//   return Card(
//     margin: EdgeInsets.symmetric(vertical: 2),
//     child: Padding(
//       padding: const EdgeInsets.only(top: 10, bottom: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Container(
//                     margin: EdgeInsets.only(
//                         left: MediaQuery.of(context).size.width * .025),
//                     width: 50,
//                     height: 70,
//                     child: Image.asset('assets/images/Group (1).png')),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .06,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${bk.title}',
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.005,
//                       ),
//                       Text(
//                         'by : ${bk.author}',
//                         style: TextStyle(fontSize: 10, color: Colors.grey[700]),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Issued : \n${bk.issuedDate}',
//                               style: TextStyle(
//                                   fontSize: 10, color: Colors.grey[700]),
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * .05,
//                             ),
//                             Text('Return : \n${bk.returned}',
//                                 style: TextStyle(
//                                     fontSize: 10, color: Colors.grey[700])),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//               padding: EdgeInsets.only(
//                   right: MediaQuery.of(context).size.width * .04),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     bk.isPaid ? 'Paid' : 'Due',
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: (bk.isPaid) ? Colors.green : Colors.orange,
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.01,
//                   ),
//                   Text(
//                     'fine : ${bk.fineAmount}',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                   SizedBox(
//                     height: 7,
//                   ),
//                   Text(
//                     '${bk.lateDays}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Text(
//                     'days late',
//                     style: TextStyle(
//                       fontSize: 10,
//                     ),
//                   ),
//                 ],
//               )),
//         ],
//       ),
//     ),
//   );
// }
