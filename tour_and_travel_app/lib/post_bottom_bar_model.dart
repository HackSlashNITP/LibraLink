class PostBottomBarModel {
  final String image;
  final double rating;
  final String location;
  PostBottomBarModel({
    required this.image,
    required this.rating,
    required this.location,
  });
}

List<PostBottomBarModel> postBottomBar = [
  PostBottomBarModel(
    image: "images/city5.jpg",
    rating: 4.4,
    location: "Buckingham Palace",
  ),
  PostBottomBarModel(
    image: "images/city4.jpg",
    rating: 4.2,
    location: "Tower of London",
  ),
  PostBottomBarModel(
    image: "images/city3.jpg",
    rating: 4.0,
    location: "Big Ben",
  ),
  PostBottomBarModel(
    image: "images/city2.jpg",
    rating: 4.5,
    location: "Big Ben",
  ),
  PostBottomBarModel(
    image: "images/city1.jpg",
    rating: 4.6,
    location: "regis Beach",
  ),
];
