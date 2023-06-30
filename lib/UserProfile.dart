class UserProfile {
  final String email;
  final String username;
  final String fName;
  final String lName;
  final String dateOfBirth;
  final String phone;

  UserProfile({
    required this.email,
    required this.username,
    required this.fName,
    required this.lName,
    required this.dateOfBirth,
    required this.phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'],
      username: json['username'],
      fName: json['fName'],
      lName: json['lName'],
      dateOfBirth: json['date_of_birth'],
      phone: json['phone'],
    );
  }
}
