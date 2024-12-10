import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _secondName = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '';

  RegistrationScreen({super.key});

  // Registration function that makes the POST request to the PHP script
  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Define the URL to your PHP script (Update this URL based on where your PHP script is hosted)
      const String url = 'http://localhost/fruitmarket/register.php'; // Use your actual IP or ngrok URL

      // Send POST request to the PHP script
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'firstname': _firstName,
            'secondname': _secondName,
            'email': _email,
            'password': _password,
            'phone': _phoneNumber,
          },
        );

        // Debugging the response
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');

        // Parse the response
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          Navigator.pop(context); // Return to Login Screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful, please log in')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'])),
          );
        }
      } catch (error) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error connecting to server.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register', style: TextStyle(color: Color.fromARGB(255, 38, 237, 7))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Logo
              Image.asset('logo.jpeg', height: 150.0),

              // Title
              const Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 38, 237, 7)),
              ),
              const SizedBox(height: 20),

              // First Name Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your first name' : null,
                onSaved: (value) => _firstName = value!,
              ),
              const SizedBox(height: 16),

              // Second Name Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Second Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your second name' : null,
                onSaved: (value) => _secondName = value!,
              ),
              const SizedBox(height: 16),

              // Email Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) => value!.contains('@') ? null : 'Please enter a valid email',
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                onSaved: (value) => _phoneNumber = value!,
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () => _register(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: const Color.fromARGB(255, 38, 237, 7),
                ),
                child: const Text('Register', style: TextStyle(fontSize: 16)),
              ),

              // Back to Login Link
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Login', style: TextStyle(color: Color.fromARGB(255, 38, 237, 7))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
