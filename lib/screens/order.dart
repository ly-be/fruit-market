import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Order extends StatelessWidget {
  // Sample cart data passed as a parameter (you could manage this with GetX or any state management)
  final List<Map<String, dynamic>> cart = [
    {'name': 'Fruit Salad', 'price': 50.0, 'quantity': 1},
    {'name': 'Juice', 'price': 100.0, 'quantity': 2},
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate the total price
    double totalPrice = cart.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 175, 80),
        title: const Text("Order Summary"),
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: () {
              Get.offAndToNamed("/settings");
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Order",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Display cart items
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.local_dining),
                      title: Text(item['name']),
                      subtitle: Text('KSh ${item['price']} x ${item['quantity']}'),
                      trailing: Text('Total: KSh ${item['price'] * item['quantity']}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Total Price
            Text(
              'Total Price: KSh ${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showSizeSelection(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 76, 175, 80),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Select Item Size and Proceed',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Proceed to checkout (this could navigate to a checkout screen)
                Get.snackbar("Checkout", "Proceeding to checkout...");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSizeSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Size for Your Order",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Small (50)"),
                onTap: () {
                  Get.snackbar("Size Selected", "Small size selected.");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.crop_square),
                title: const Text("Medium (100)"),
                onTap: () {
                  Get.snackbar("Size Selected", "Medium size selected.");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.desktop_windows),
                title: const Text("Large (150)"),
                onTap: () {
                  Get.snackbar("Size Selected", "Large size selected.");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
