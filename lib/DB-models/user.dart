class user {
  final String username;
  final String uid;
  final String name;
  final String contact;
  final String roll;
  final String email;
  final String IdURL;
  final String profileURL;

  const user({
    required this.username,
    required this.uid,
    required this.name,
    required this.contact,
    required this.roll,
    required this.email,
    required this.IdURL,
    required this.profileURL,
  });
  Map<String, dynamic> tojson() => {
        "username": username,
        "uid": uid,
        "name": name,
        "contact": contact,
        "roll": roll,
        "email": email,
        "Id": IdURL,
        "Profile": profileURL,
      };
}
