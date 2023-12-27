import 'package:flutter/material.dart';
import '../books model/previous.dart';
class PreviousBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return ListView.builder(

      itemCount: prevbooks.length,
      itemBuilder: (context, index) {
        return _buildPreviousBookItem(prevbooks[index],context);
      },);
  }
  }

Widget _buildPreviousBookItem(Previous_Book bk, BuildContext context) {
  return Card(
      margin: EdgeInsets.symmetric(vertical: 2),
 child: Padding(
  padding: const EdgeInsets.only(top: 10, bottom: 10),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  Expanded(
  child: Row(
  children: [
  Container(
  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * .025),
  width: 50,
  height: 70,
  child: Image.asset(bk.url)),
  SizedBox(
  width: MediaQuery.of(context).size.width * .06,
  ),
  Expanded(
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
   Text(
  '${bk.title}',
  style: TextStyle(
  fontSize: 15, fontWeight: FontWeight.bold),
  ),SizedBox(
    height:MediaQuery.of(context).size.height*0.005,
   ),
   Text(
  'by : ${bk.author}',
  style: TextStyle(fontSize: 10,color: Colors.grey[700]),
  ),
  Padding(
  padding: const EdgeInsets.only(top: 10),
  child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
   Text('Issued : \n${bk.issuedate}',style: TextStyle(fontSize: 10,color: Colors.grey[700]),),
  SizedBox(
  width: MediaQuery.of(context).size.width * .05,
  ),
   Text('Return : \n${bk.returndate}', style: TextStyle(fontSize: 10,color: Colors.grey[700])),
  ],
  ),
  )
  ],
  ),
  ),
  ],
  ),
  ),
  Padding(
  padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width  * .04),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
  Text(
  '${bk.dues}',
  style: TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.bold,
  color: ('${bk.dues}'== 'Paid') ? Colors.green : Colors.orange,
  ),),
  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
  Text(
  'fine : ${bk.fine}',
  style: TextStyle(fontSize: 10),
  ),
  SizedBox(
  height: 7,
  ),
  Text(
  '${bk.days}',
  style: TextStyle(
  fontSize: 12,
   color: Colors.grey,
  ),
  ),
  Text(
  'days late',
  style: TextStyle(
  fontSize: 10,
  ),
  ),
  ],
  )),
  ],
  ),
  ),);}