import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:chapter_7/UserProfile.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String accessToken;
  final String refreshToken;

  ProfilePage({required this.accessToken, required this.refreshToken});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  void _fetchProfileData() {
    final url = Uri.parse('http://127.0.0.1:8000/api/user/profile/');
    final headers = {'Authorization': 'Bearer ${widget.accessToken}'};

    _profileFuture = http.get(url, headers: headers).then((response) {
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserProfile.fromJson(responseData);
      } else {
        throw Exception('Failed to fetch profile data');
      }
    }).catchError((error) {
      throw Exception('An error occurred: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: FutureBuilder<UserProfile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final userProfile = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${userProfile.email}'),
                Text('Username: ${userProfile.username}'),
                Text('First Name: ${userProfile.fName}'),
                Text('Last Name: ${userProfile.lName}'),
                Text('Date of Birth: ${userProfile.dateOfBirth}'),
                Text('Phone: ${userProfile.phone}'),
              ],
            );
          }
        },
      ),
    );
  }
}
