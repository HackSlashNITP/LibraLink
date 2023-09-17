//ignore_for_file: public_member_api_docs, sort_constructors_first
class RecommendedPlaceModel {
  final String image;
  final double rating;
  final String location;
  RecommendedPlaceModel({
    required this.image,
    required this.rating,
    required this.location,
  });
}

List<RecommendedPlaceModel> recommendedPlaces = [
  RecommendedPlaceModel(
    image: "images/city5.jpg",
    rating: 4.4,
    location: "Buckingham Palace",
  ),
  RecommendedPlaceModel(
    image: "images/city4.jpg",
    rating: 3.6,
    location: "Tower of London",
  ),
  RecommendedPlaceModel(
    image: "images/city3.jpg",
    rating: 4.0,
    location: "Big Ben",
  ),
  RecommendedPlaceModel(
    image: "images/city2.jpg",
    rating: 4.5,
    location: "Big Ben",
  ),
  RecommendedPlaceModel(
    image: "images/city1.jpg",
    rating: 4.6,
    location: "regis Beach",
  ),
];
