import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../configs/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override 
  _LoginScreenState createState() => _LoginScreenState();
}

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  // Function to handle login
  void _login() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    final response = await http.post(
      Uri.parse('http://localhost/fruitmarket/login.php'),
      body: {
        'email': _username,
        'password': _password,
      },
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200 && responseData['status'] == 'success') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("Username", _username);

      if (responseData.containsKey('user_id')) {
        final id = responseData['user_id'].toString();
        context.read<AuthProvider>().login(id);
      }

      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'] ?? 'Login failed')),
      );
    }
  }
}


  getValue() async {
    _usernameController.text = await readpref();
  }

  @override
  Widget build(BuildContext context) {
    getValue(); // Auto-populate username from shared preferences
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              Image.asset('logo.jpeg', height: 150.0),

              // Title
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 38, 237, 7)),
              ),
              const SizedBox(height: 20),

              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
                onSaved: (value) => _username = value!,
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password' : null,
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () async {
                  // If either field is empty, show a snack bar with a message
                  if (_usernameController.text.isEmpty) {
                    Get.snackbar(
                      "Validation",
                      "Please enter your email",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: mainColor,
                      colorText: appWhite,
                      icon: const Icon(Icons.error, color: appWhite),
                    );
                  } else if (_passwordController.text.isEmpty) {
                    Get.snackbar(
                      "Validation",
                      "Please enter your password",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: mainColor,
                      colorText: appWhite,
                      icon: const Icon(Icons.error, color: appWhite),
                    );
                  } else {
                    // If validation passes, save the form and call _login
                    _login();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: const Color.fromARGB(255, 38, 237, 7),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),

              // Registration Link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Create an Account',
                    style: TextStyle(color: Color.fromARGB(255, 38, 237, 7))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  readpref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String storedUsername = pref.getString("Username") ?? "";
    return storedUsername;
  }
}
