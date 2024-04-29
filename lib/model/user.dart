typedef Json = Map<String, dynamic>;

class User {
  final String gender;
  final String email;
  final String name;
  final String phone;
  final String nat;

  /*
      v2
      User({
      required this.gender,
      required this.email,
      required this.name,
      required this.phone,
      required this.nat,
      });
   */

  User.fromJson(Json json)
      : gender = json['gender'],
        email = json['email'],
        name = json['name'],
        phone = json['phone'],
        nat = json['nat'];
}
