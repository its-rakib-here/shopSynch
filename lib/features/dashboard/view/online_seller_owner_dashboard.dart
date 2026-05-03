import 'package:flutter/material.dart';

class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F9FB),

      // 🔝 AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "ShopSync Pro",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {},
          )
        ],
      ),

      // 📱 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Overview",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text("Today"),

            const SizedBox(height: 20),

            // ⚡ Quick Actions
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _quickButton(Icons.add_shopping_cart, "Add Order", true),
                _quickButton(Icons.person_add, "Customer", false),
                _quickButton(Icons.inventory_2, "Product", false),
                _quickButton(Icons.store, "Shop", false),
              ],
            ),

            const SizedBox(height: 20),

            // 📊 KPI Cards
            Row(
              children: [
                Expanded(child: _kpiCard("Revenue", "৳24,500", Colors.blue)),
                const SizedBox(width: 10),
                Expanded(child: _kpiCard("Due", "৳3,240", Colors.red)),
                const SizedBox(width: 10),
                Expanded(child: _kpiCard("Orders", "1432", Colors.green)),
              ],
            ),

            const SizedBox(height: 20),

            // 📈 Chart Placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text("Sales Chart Here"),
              ),
            ),

            const SizedBox(height: 20),

            // ⚠️ Stock Alerts
            const Text(
              "Stock Alerts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _stockItem("Premium Widgets", "Out of Stock", Colors.red),
            _stockItem("Basic Gadgets", "Low Stock", Colors.orange),

            const SizedBox(height: 20),

            // 👥 Customers
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  CircleAvatar(radius: 12),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 12),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 12),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2,405",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Active Customers"),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      // 📌 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Ops"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Stock"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  // 🔹 Quick Button
  Widget _quickButton(IconData icon, String text, bool primary) {
    return Container(
      decoration: BoxDecoration(
        color: primary ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primary ? Colors.white : Colors.black),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: primary ? Colors.white : Colors.black,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  // 🔹 KPI Card
  Widget _kpiCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Stock Item
  Widget _stockItem(String name, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(status, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}