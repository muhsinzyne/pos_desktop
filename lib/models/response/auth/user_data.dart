class UserData {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  UserData();
  UserData.fromJSON(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    username = parsedJson['username'];
    firstName = parsedJson['first_name'];
    lastName = parsedJson['last_name'];
    email = parsedJson['email'];
    token = parsedJson['token'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'fist_name': firstName,
        'last_name': lastName,
        'email': email,
        'token': token,
      };
}
