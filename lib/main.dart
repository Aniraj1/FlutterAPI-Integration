import 'package:chapter_7/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _tcController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  // Add more controllers for other fields

  void _signup() async {
    String email = _emailController.text;
    String username = _usernameController.text;
    String fName = _fNameController.text;
    String lName = _lNameController.text;
    String dateOfBirth = _dateOfBirthController.text;
    bool tc = _tcController.text.toLowerCase() == 'true';
    String phone = _phoneController.text;
    String password = _passwordController.text;
    String password2 = _password2Controller.text;
    // Retrieve values from other fields

    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/user/register/'),
      body: {
        'email': email,
        'username': username,
        'fName': fName,
        'lName': lName,
        'date_of_birth': dateOfBirth,
        'tc': tc.toString(),
        'phone': phone,
        'password': password,
        'password2': password2,
        // Pass other fields as well
      },
    );

    if (response.statusCode == 201) {
      // Signup successful
      // Perform any necessary actions (e.g., navigation, showing a success message)
    } else {
      // Signup failed
      // Handle the error (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _fNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: _lNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              controller: _dateOfBirthController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
              ),
            ),
            TextField(
              controller: _tcController,
              decoration: InputDecoration(
                labelText: 'Terms and Conditions',
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            TextField(
              controller: _password2Controller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
