import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/screens/cart.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // List to hold the fruits data fetched from the API
  List<dynamic> fruits = [];
  List<Map<String, dynamic>> cart = [];  // List to store the cart items
  
  bool isLoading = true;
  String errorMessage = '';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${fruit['name']} has been added to the cart!'),
        backgroundColor: Colors.green.shade100,
      ),
    );

    // Navigate to the CartTab
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartTab()), // Navigate to CartTab
    );
  }

  @override
  void initState() {
    super.initState();
    fetchFruits(); // Fetch fruits when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Salad & Juice Menu'),
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
                                addToCart(fruit);  // Call the addToCart function
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

// JuiceScreen remains unchanged
class JuiceScreen extends StatefulWidget {
  const JuiceScreen({super.key});

  @override
  _JuiceScreenState createState() => _JuiceScreenState();
}

class _JuiceScreenState extends State<JuiceScreen> {
  // List to hold the juices data fetched from the API
  List<Map<String, dynamic>> juices = [];

  // Fetch juices data from the PHP script
  Future<void> fetchJuices() async {
    final response = await http.get(Uri.parse('http://localhost/fruitmarket/juices.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        juices = data.map((juice) {
          return {
            'name': juice['juice_name'],
            'price': juice['juice_price'],
            'image': juice['image_url'],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load juices');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJuices(); // Fetch juices when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juice Menu'),
        backgroundColor: const Color.fromARGB(255, 76, 175, 80),
      ),
      body: juices.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while fetching
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: juices.length,
                itemBuilder: (context, index) {
                  final juice = juices[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          juice['image'],  // Use image from the URL
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          juice['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'KSh ${juice['price'] != null ? double.tryParse(juice['price'].toString())?.toStringAsFixed(2) ?? '0.00' : '0.00'}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            print('${juice['name']} added to cart');
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
void _addToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartTab()),
);
}
