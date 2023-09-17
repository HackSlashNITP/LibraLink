import 'package:flutter/material.dart';
import 'package:tour_and_travel_app/contents.dart';
import 'package:tour_and_travel_app/tourist_details_page.dart';

class RecommendedPlaces extends StatefulWidget {
  const RecommendedPlaces({super.key});

  @override
  State<RecommendedPlaces> createState() => _RecommendedPlacesState();
}

class _RecommendedPlacesState extends State<RecommendedPlaces> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: visit.length,
        itemBuilder: (context, index) {
          Map place = visit[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TouristPlaces(
                            place: place,
                          ))),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 250,
                    padding: const EdgeInsets.only(
                      top: 135,
                    ),
                    child: ListTile(
                      title: Text(place['name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 18.0,
                            color: Colors.white,
                          ),
                          Text(
                            place['location'],
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      trailing: Text(place['price'],
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(place['image'])),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
