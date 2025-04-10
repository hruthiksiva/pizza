import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final List<dynamic> items = args["items"];
    final Map<int, int> quantities = args["quantities"];

    final List<Map<String, dynamic>> cartItems = items
        .where((item) => (quantities[item['id']] ?? 0) > 0)
        .map((item) => {
              "id": item["id"],
              "name": item["name"],
              "price": item["price"],
              "quantity": quantities[item["id"]],
              "image": item["image"]
            })
        .toList();

    num totalAmount = 0;
    cartItems.forEach((item) {
      totalAmount += item["price"] * item["quantity"];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Your cart is empty!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.asset(
                          item["image"],
                          width: 50,
                          height: 50,
                        ),
                        title: Text(item["name"]),
                        subtitle:
                            Text("₹${item["price"]} x ${item["quantity"]}"),
                        trailing: Text(
                            "₹${item["price"] * item["quantity"]}"),
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹$totalAmount",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/payment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text("Proceed to Payment", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
