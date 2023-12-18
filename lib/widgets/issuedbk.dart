import 'package:flutter/material.dart';
import 'package:libralink/books%20model/issued_books.dart';

class IssuedBookPg extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildBookItem(items[index],context);
          },


    );
  }


  Widget _buildBookItem(Item book, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical:4),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(

                      width: 50,
                      height: 70,
                      child: Image.asset(book.url)),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .06,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height:MediaQuery.of(context).size.height*0.005,
                        ),
                        Text(
                          'by: ${book.author}',
                          style: TextStyle(fontSize: 10,
                          color: Colors.grey[700]),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Issued : \n${book.issuedate}',
                              style:TextStyle(fontSize:10)),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width* .05,
                              ),
                              Text('Return : \n${book.returndate}',style:TextStyle(fontSize:10)),
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
              padding: EdgeInsets.only(right: MediaQuery
                  .of(context)
                  .size
                  .width * .06),
              child:  Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .075,


                child: Column(
                  children: [
                    Text(
                      '${book.days}'
                      ,style: TextStyle(fontSize: 20, color: Color(0xffFF693D)),
                    ),
                    Text(
                      'days'
                      ,style: TextStyle(fontSize: 15, color: Color(0xffFF693D)),
                    ),
                    Text(
                      'left'
                      ,style: TextStyle(fontSize: 10, color: Color(0xffFF693D)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),);
  }
}


