import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tour_and_travel_app/HomeAppBar.dart';
import 'recommended_places.dart';
import 'package:tour_and_travel_app/tourist_place.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour_and_travel_app/nearby_places.dart';
import 'package:tour_and_travel_app/contents.dart';

import 'nearby_places.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map place = visit[0];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: HomeAppBar(),
      ),
      bottomNavigationBar: GNav(
        color: Colors.grey[700], // unselected icon color
        activeColor: Colors.red,
        tabs: [
          GButton(icon: Icons.home),
          GButton(icon: Icons.favorite),
          GButton(icon: Icons.shopping_cart),
          GButton(icon: Icons.person),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 17),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Category",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton(onPressed: () {}, child: Text("View All ->"))
            ],
          ),
          SizedBox(height: 17),
          TouristPlace(),
          const SizedBox(height: 15),
          RecommendedPlaces(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Destination",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton(onPressed: () {}, child: Text("View All ->"))
            ],
          ),
          const SizedBox(height: 15),
          NearbyPlaces(),
        ],
      ),
    );
  }
}
