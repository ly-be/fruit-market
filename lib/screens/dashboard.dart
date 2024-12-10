import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/cart.dart';  // Add the Cart screen here
import 'package:my_app/screens/profiles.dart';
import 'package:my_app/screens/settings.dart';
import 'package:my_app/screens/wallet.dart';

import '../controllers/dashboardcontroller.dart';

// Menu items for the BottomNavigationBar
List<BottomNavigationBarItem> myMenus = [
  const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),  // Changed "Order" to "Cart"
  const BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
  const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
];

// Screens corresponding to each BottomNavigationBar item
List<Widget> myScreens = [
  const Home(),
  const CartTab(),  // Replace Order screen with Cart screen
  const WalletTab(),
  const Settings(),
  const Profile(),
];

// GetX controller instance
DashboardController dashboardController = Get.put(DashboardController());

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: myMenus,
            selectedItemColor: Colors.green, // Theme color
            selectedLabelStyle: const TextStyle(color: Colors.green),
            unselectedItemColor: Colors.black87,
            showUnselectedLabels: true,
            onTap: (val) => dashboardController.updateSelectedMenu(val),
            currentIndex: dashboardController.selectedMenu.value,
            backgroundColor: Colors.green.withOpacity(0.2),
            unselectedLabelStyle: const TextStyle(color: Colors.black87),
          )),
      body: Obx(() => myScreens[dashboardController.selectedMenu.value]),
    );
  }
}
