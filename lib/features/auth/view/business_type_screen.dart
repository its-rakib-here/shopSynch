import 'package:flutter/material.dart';

class BusinessTypeScreen extends StatefulWidget {
  const BusinessTypeScreen({super.key});

  @override
  State<BusinessTypeScreen> createState() => _BusinessTypeScreenState();
}

class _BusinessTypeScreenState extends State<BusinessTypeScreen> {
  String selectedType = "hybrid";

  void selectType(String type) {
    setState(() {
      selectedType = type;
    });
  }

  Widget buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final isSelected = selectedType == value;

    return GestureDetector(
      onTap: () => selectType(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
              isSelected ? Colors.blue : Colors.grey.shade200,
              child: Icon(icon,
                  color: isSelected ? Colors.white : Colors.black54),
            ),
            const SizedBox(width: 12),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),

            /// CHECK ICON
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  void onContinue() {
    debugPrint("Selected Business Type: $selectedType");

    // 👉 Save in backend later
     Navigator.pushNamed(context, "/online_seller_owner_dashboard.dart");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Business Type")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            buildCard(
              title: "Physical Shop",
              subtitle:
              "POS system, barcode scanning, offline sales management",
              icon: Icons.store,
              value: "physical",
            ),

            buildCard(
              title: "Online Seller",
              subtitle:
              "E-commerce orders, courier integration, fulfillment",
              icon: Icons.shopping_cart,
              value: "online",
            ),

            buildCard(
              title: "Hybrid Mode",
              subtitle:
              "Manage both physical + online business in one system",
              icon: Icons.sync,
              value: "hybrid",
            ),

            const Spacer(),

            /// CONTINUE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text("Continue"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}