import 'package:flutter/material.dart';
import 'wallet.dart';
import 'wallet_tab.dart'; // Import the WalletTab

// Cart Model
class CartItem {
  final String image;
  final String title;
  final String price;
  int quantity;

  CartItem({
    required this.image,
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => double.parse(price) * quantity;
}

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  // List of items in the cart
  List<CartItem> cartItems = [];

  // Calculate subtotal, discount, and total
  double get subTotal {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get discount => 100.0;
  double get total => subTotal - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 194, 210, 202), // Light Beige Background
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50), // Green AppBar color
        title: const Text('Your Cart', style: TextStyle(color: Color.fromARGB(255, 194, 210, 202))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items List
            const Text(
              'Items in Cart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50), // Green text color
              ),
            ),
            const SizedBox(height: 10),
            ...cartItems.map((item) => _CartItemCard(item: item, onUpdate: _updateCartItem, onRemove: _removeCartItem)).toList(),
            const SizedBox(height: 20),

            // Order Summary
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50), // Green text color
              ),
            ),
            const SizedBox(height: 10),
            _OrderSummary(
              subTotal: subTotal.toStringAsFixed(2),
              discount: discount.toStringAsFixed(2),
              total: total.toStringAsFixed(2),
            ),
            const SizedBox(height: 20),

            // Proceed to Checkout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to WalletTab
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletTab()), // Navigate to WalletTab
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Green button background
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontSize: 16, color: Colors.white), // White text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Update item quantity
  void _updateCartItem(CartItem item, int newQuantity) {
    setState(() {
      item.quantity = newQuantity;
    });
  }

  // Remove item from the cart
  void _removeCartItem(CartItem item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  // Add item to the cart (example)
  void addItemToCart(String image, String title, String price) {
    setState(() {
      cartItems.add(CartItem(image: image, title: title, price: price));
    });
  }
}

// Cart Item Card Widget
class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function(CartItem, int) onUpdate;
  final Function(CartItem) onRemove;

  const _CartItemCard({
    required this.item,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFDE8E0), // Light background for cart items
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(item.image, width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50), // Green text color
                  ),
                ),
                Text(
                  'Ksh ${item.price}',
                  style: const TextStyle(
                    color: Color(0xFF4CAF50), // Green text color
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(color: Color(0xFF4CAF50)), // Green text color
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(color: Color(0xFF4CAF50)), // Green text color
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.remove, color: Color(0xFF4CAF50)), // Green icon color
                      onPressed: item.quantity > 1 ? () => onUpdate(item, item.quantity - 1) : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Color(0xFF4CAF50)), // Green icon color
                      onPressed: () => onUpdate(item, item.quantity + 1),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Color(0xFF4CAF50)), // Green icon color
                      onPressed: () => onRemove(item),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Order Summary Widget
class _OrderSummary extends StatelessWidget {
  final String subTotal;
  final String discount;
  final String total;

  const _OrderSummary({
    required this.subTotal,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFDE8E0), // Light background for summary
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _OrderSummaryRow(label: 'Subtotal', amount: 'Ksh $subTotal'),
            _OrderSummaryRow(label: 'Discount', amount: 'Ksh $discount'),
            const Divider(color: Color(0xFF4CAF50)), // Green divider
            _OrderSummaryRow(label: 'Total', amount: 'Ksh $total'),
          ],
        ),
      ),
    );
  }
}

class _OrderSummaryRow extends StatelessWidget {
  final String label;
  final String amount;

  const _OrderSummaryRow({
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))), // Green text color
        Text(amount, style: const TextStyle(color: Color(0xFF4CAF50))), // Green text color
     ],
);
}
}
