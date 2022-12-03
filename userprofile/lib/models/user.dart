class User {
  String id;
  String firstName;
  String lastName;
  String displayName;
  String email;
  String age;
  String country;
  String city;
  String major;
  String profileImagePath;
  String coverImagePath;

  User(
      {this.id = '',
      required this.firstName,
      required this.email,
      required this.lastName,
      required this.displayName,
      required this.age,
      required this.country,
      required this.city,
      required this.major,
      required this.profileImagePath,
      required this.coverImagePath});

  Map<String, dynamic> toJson() => {
        'id': id,
        'age': age,
        'city': city,
        'country': country,
        'display name': displayName,
        'email': email,
        'first name': firstName,
        'last name ': lastName,
        'major': major,
      };

  static User fromJson(Map<String, dynamic> json) => User(
      age: json['age'],
      city: json['city'],
      country: json['country'],
      displayName: json['display name'],
      email: json['email'],
      firstName: json['first name'],
      lastName: json['last name '],
      major: json['major'],
      coverImagePath: 'cover image',
      profileImagePath: 'profile image');
}
