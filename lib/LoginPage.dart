import 'package:chapter_7/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  void _login() {
    final url = Uri.parse('http://127.0.0.1:8000/api/user/login/');
    final data = {'email': email, 'password': password};

    http.post(url, body: data).then((response) {
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final accessToken = responseData['token']['access'];
        final refreshToken = responseData['token']['refresh'];

        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              accessToken: accessToken,
              refreshToken: refreshToken,
            ),
          ),
        );
      } else {
        final error = jsonDecode(response.body)['errors']['non_field_errors'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => setState(() => email = value),
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              onChanged: (value) => setState(() => password = value),
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
