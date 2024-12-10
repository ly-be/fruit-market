import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    const url = 'http://localhost/fruitmarket/profile/get.php?user_id=15'; // Adjust user_id as needed
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            userData = data['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            hasError = true;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError || userData == null
              ? const Center(
                  child: Text(
                    "Failed to load user data",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  const AssetImage("assets/images/profile_pic.jpg"),
                              backgroundColor: Colors.grey[300],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  // Logic to change profile picture
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // User Details
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text("${userData!['firstname']} ${userData!['secondname']}"),
                        subtitle: const Text("Full Name"),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Logic to edit full name
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(userData!['email']),
                        subtitle: const Text("Email Address"),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Logic to edit email
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(userData!['phone']),
                        subtitle: const Text("Phone Number"),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Logic to edit phone number
                          },
                        ),
                      ),
                      const Divider(),

                      // Account Security
                      ListTile(
                        leading: const Icon(Icons.lock),
                        title: const Text("Change Password"),
                        onTap: () {
                          // Navigate to change password screen
                        },
                      ),
                      const Divider(),

                      // Notifications and Preferences
                      SwitchListTile(
                        value: true,
                        onChanged: (val) {
                          // Toggle notification setting
                        },
                        title: const Text("Enable Notifications"),
                        secondary: const Icon(Icons.notifications),
                      ),
                      const Divider(),

                      // Logout and Account Deletion
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Logic to log out
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Logout"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Logic for account deletion
                        },
                        child: const Text("Delete Account",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
    );
  }
}
