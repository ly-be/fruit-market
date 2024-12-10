import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // App Preferences
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "App Preferences",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: SwitchListTile(
              title: const Text("Dark Mode"),
              secondary: const Icon(Icons.brightness_6),
              value: false, // Replace with actual dark mode state
              onChanged: (value) {
                // Toggle dark mode
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: SwitchListTile(
              title: const Text("Notifications"),
              secondary: const Icon(Icons.notifications),
              value: true, // Replace with actual notification state
              onChanged: (value) {
                // Toggle notifications
              },
            ),
          ),
          const Divider(),

          // Security Settings
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Security",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.fingerprint),
              title: const Text("Biometric Authentication"),
              onTap: () {
                // Logic for enabling biometric authentication
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text("App Lock"),
              onTap: () {
                // Logic for setting a PIN or password
              },
            ),
          ),
          const Divider(),

          // General Settings
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "General",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About Us"),
              onTap: () {
                // Show app info
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text("Privacy Policy"),
              onTap: () {
                // Open Privacy Policy page
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.gavel),
              title: const Text("Terms of Service"),
              onTap: () {
                // Open Terms of Service page
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Help & Support"),
              onTap: () {
                // Show help options
              },
            ),
          ),
          const Divider(),

          // Other Options
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Other",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.restore),
              title: const Text("Reset App Data"),
              onTap: () {
                // Logic to reset app data
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Clear Cache"),
              onTap: () {
                // Logic to clear app cache
              },
            ),
          ),
        ],
      ),
    );
  }
}
