import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // Check if arguments is not null and is of type RemoteMessage
    if (arguments is RemoteMessage) {
      final message = arguments;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
          title: Text(
            '${message.notification?.title.toString()}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '${message.notification?.body.toString()}',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        backgroundColor: Colors.white70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                    child: Text(
                      '${message.data.toString()}',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      // Handle the case where arguments is not a RemoteMessage
      return const Scaffold(
        body: Center(
          child: Text('No Notifications for now!'),
        ),
      );
    }
  }
}
