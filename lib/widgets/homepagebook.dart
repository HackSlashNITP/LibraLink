import 'package:flutter/material.dart';

import 'package:libralink/books%20model/homePage.dart';
class MyListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      padding: EdgeInsets.all(0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MyListItem(
          title: items[index].title,
          date: items[index].date,
          imagePath: items[index].url,
        );
      },
    );
  }
}

class MyListItem extends StatelessWidget {
  final String title;
  final String date;
  final String imagePath;

  MyListItem({required this.title, required this.date, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
        margin: EdgeInsets.only(top:10), // Remove space
        elevation: 0.0,
      color: Color.fromARGB(255, 235, 233, 233),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10,left: 0),
              width: screenSize.width*0.5,
            height: screenSize.height*0.07,
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0, left: 0,),

                  child: Text(this.date, style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0, left: 0,top: 5),
                  child: Text(
                    this.title,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),),
            SizedBox(
              width: screenSize.width*0.15
            ),



            // Right side with the image
            Container(

              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  imagePath,
                  width: 42,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),

    );
  }
}