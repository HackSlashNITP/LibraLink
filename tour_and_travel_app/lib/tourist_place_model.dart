//ignore_for_file: public_member_api_docs, sort_constructors_first
class TouristPlacesModel {
  final String name;
  final String image;
  final String location;
  final String detail;
  TouristPlacesModel({
    required this.name,
    required this.image,
    required this.location,
    required this.detail,
  });
}

List<TouristPlacesModel> touristPlaces = [
  TouristPlacesModel(
      name: "Mountain",
      image: "images/city1.jpg",
      location: "Regis Beach",
      detail:
          "The harbour is well known for as the Cobb , appears in Jahn Foweles novel The French Liutenants Women"
          " party shot in the town"),
  TouristPlacesModel(
      name: "City",
      image: "images/city2.jpg",
      location: "Tower Bridge",
      detail:
          "Enjoy the iconic panormic views of london , from the Tower of London to St Pauls in the west ."),
  TouristPlacesModel(
      name: "Waterfall",
      image: "images/city3.jpg",
      location: "Big Ben",
      detail:
          "Big Ben is the worlds most famous clock .It is famous for its accuracy and for its massive bells"),
  TouristPlacesModel(
      name: "River",
      image: "images/city4.jpg",
      location: "Big Ben",
      detail:
          "Big Ben is the worlds most famous clock .It is famous for its accuracy and for its massive bells"),
  TouristPlacesModel(
      name: "Beaches",
      image: "images/city5.jpg",
      location: "Tower Bridge",
      detail:
          "Buckingham palace is a royal residence in london and administrative headquarter of monarch of UK"),
  TouristPlacesModel(
      name: "River",
      image: "images/city4.jpg",
      location: "Piccadilly Circus",
      detail:
          "A commercial hub in the 17th century .This place is heart of london arts ."),
];
