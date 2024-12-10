import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:my_app/screens/cart.dart';
import 'package:my_app/screens/dashboard.dart'; // For navigation to Dashboard


class FruitSaladScreen extends StatefulWidget {
  const FruitSaladScreen({super.key});

  @override
  _FruitSaladScreenState createState() => _FruitSaladScreenState();
}

class _FruitSaladScreenState extends State<FruitSaladScreen> {
  List<dynamic> fruits = [];
  bool isLoading = true;
  String errorMessage = '';
  List<Map<String, dynamic>> cart = []; // List to store the cart items

  @override
  void initState() {
    super.initState();
    fetchFruits();
  }

  // Fetch fruits data from the PHP script
  Future<void> fetchFruits() async {
    const String url = 'http://localhost/fruitmarket/fetchFruits.php'; // Use IP address for Emulator

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> fetchedFruits = jsonDecode(response.body);

        setState(() {
          fruits = fetchedFruits;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  // Add item to the cart and navigate to the CartTab
  void addToCart(Map<String, dynamic> fruit) {
    setState(() {
      cart.add(fruit);
    });

    // Provide feedback to the user
    Get.snackbar(
      'Added to Cart',
      '${fruit['name']} has been added!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      duration: const Duration(seconds: 2),
    );

    // Navigate to the CartTab
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartTab()), // Navigate to CartTab
    );
  }

  // Add item to the cart (HomeTab style)
  void addItemToCart(Map<String, dynamic> fruit) {
    // Same logic as addToCart, for the HomeTab
    addToCart(fruit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Salad'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: fruits.length,
                    itemBuilder: (context, index) {
                      final fruit = fruits[index];
                      final name = fruit['name'] ?? 'Unknown';
                      final price = fruit['price'] != null
                          ? double.tryParse(fruit['price'].toString()) ?? 0.0
                          : 0.0;
                      final imageUrl = fruit['image_url'] ?? 'http://localhost/fruitmarket/fetchFruits.php';

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                imageUrl,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'KSh ${price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                addItemToCart(fruit);  // Call the HomeTab's addItemToCart function
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
