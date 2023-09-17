import 'package:flutter/material.dart';
import 'package:tour_and_travel_app/contents.dart';

class TouristPlaces extends StatefulWidget {
  final Map place;
  const TouristPlaces({
    Key? key,
    required this.place,
  }) : super(key: key);
  @override
  State<TouristPlaces> createState() => _TouristPlacesState();
}

class _TouristPlacesState extends State<TouristPlaces> {
  IconData icon = Icons.favorite_border;
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SizedBox(
            height: 300,
            width: double.maxFinite,
            child: Stack(
              // fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(widget.place['image']),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (active) {
                              icon = Icons.favorite_rounded;
                              active = false;
                            } else {
                              icon = Icons.favorite_border;
                              active = true;
                            }
                          });
                        },
                        icon: Icon(
                          icon,
                          color: Colors.red,
                        )),
                  ),
                )
              ],
            ),
          ),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              height: 480,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(
                    widget.place['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 17,
                        weight: 10,
                      ),
                      Text(
                        widget.place['location'],
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Text(
                    widget.place['price'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    widget.place['detail'],
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Preview',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )
                      ],
                    )),
                    Text(
                      widget.place['rating'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "images/city1.jpg",
                          fit: BoxFit.cover,
                          width: 120,
                          height: 90,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "images/city2.jpg",
                          fit: BoxFit.cover,
                          width: 120,
                          height: 90,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 90,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage("images/city3.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.4,
                        ),
                      ),
                      child: Text(
                        "10+",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    ));
  }
}
