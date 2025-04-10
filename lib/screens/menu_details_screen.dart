import 'package:flutter/material.dart';

class MenuDetailsScreen extends StatefulWidget {
  @override
  _MenuDetailsScreenState createState() => _MenuDetailsScreenState();
}

class _MenuDetailsScreenState extends State<MenuDetailsScreen> {
  late Map<String, dynamic> pizza;
  int quantity = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pizza = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _addToCart() {
    // In a real app, you'd add this to a cart provider or database
    Navigator.pushNamed(context, '/cart', arguments: {
      "items": [pizza],
      "quantities": {pizza['id']: quantity},
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pizza['name']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                pizza['image'],
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              pizza['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '₹${pizza['price']}',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 12),
            Text(
              pizza['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Quantity:', style: TextStyle(fontSize: 18)),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decreaseQuantity,
                ),
                Text('$quantity', style: TextStyle(fontSize: 18)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _increaseQuantity,
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addToCart,
                icon: Icon(Icons.shopping_cart),
                label: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
