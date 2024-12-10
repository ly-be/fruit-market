import 'package:flutter/material.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({super.key});

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  // Track the expanded status of each payment method
  Map<String, bool> expandedStatus = {
    'Mpesa': false,
    'PayPal': false,
    'Visa': false,
    'Google Pay': false,
    'Apple Pay': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Change theme color to green
        title: const Text('Wallet', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPaymentMethod(
              method: 'Mpesa',
              icon: Icons.phone_android,
              details: 'Enter your Mpesa phone number.',
              fields: [
                _buildTextField(label: 'Phone Number', hint: 'e.g., 0712345678'),
              ],
            ),
            const SizedBox(height: 10),
            _buildPaymentMethod(
              method: 'PayPal',
              icon: Icons.email,
              details: 'Enter your PayPal email address.',
              fields: [
                _buildTextField(label: 'Email Address', hint: 'e.g., user@example.com'),
              ],
            ),
            const SizedBox(height: 10),
            _buildPaymentMethod(
              method: 'Visa',
              icon: Icons.credit_card,
              details: 'Enter your Visa card details.',
              fields: [
                _buildTextField(label: 'Card Number', hint: 'e.g., 4111 1111 1111 1111'),
                _buildTextField(label: 'Expiry Date', hint: 'MM/YY'),
                _buildTextField(label: 'CVV', hint: '3-digit code'),
              ],
            ),
            const SizedBox(height: 10),
            _buildPaymentMethod(
              method: 'Google Pay',
              icon: Icons.payment,
              details: 'Enter your Google Pay email or phone number.',
              fields: [
                _buildTextField(label: 'Email/Phone Number', hint: 'e.g., user@example.com'),
              ],
            ),
            const SizedBox(height: 10),
            _buildPaymentMethod(
              method: 'Apple Pay',
              icon: Icons.apple,
              details: 'Enter your Apple Pay credentials.',
              fields: [
                _buildTextField(label: 'Apple ID', hint: 'e.g., user@apple.com'),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Payment method successfully selected!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Set background color to green
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Complete Payment', // Changed button text
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the payment method widget
  Widget _buildPaymentMethod({
    required String method,
    required IconData icon,
    required String details,
    required List<Widget> fields,
  }) {
    return Card(
      color: const Color.fromARGB(255, 236, 244, 242),
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.green), // Set icon color to green
            title: Text(
              method,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(details, style: const TextStyle(color: Colors.green)),
            trailing: IconButton(
              icon: Icon(
                expandedStatus[method]! ? Icons.expand_less : Icons.expand_more,
                color: Colors.green, // Set icon color to green
              ),
              onPressed: () {
                setState(() {
                  expandedStatus[method] = !expandedStatus[method]!;
                });
              },
            ),
          ),
          if (expandedStatus[method]!)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(children: fields),
            ),
        ],
      ),
    );
  }

  // Method to build a TextField widget
  Widget _buildTextField({required String label, required String hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
