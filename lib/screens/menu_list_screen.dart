import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuListScreen extends StatefulWidget {
  @override
  _MenuListScreenState createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  List<dynamic> _menuItems = [];
  Map<int, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    loadMenu();
  }

  Future<void> loadMenu() async {
    final String response = await rootBundle.loadString('lib/data/pizza_menu.json');
    final data = await json.decode(response);
    setState(() {
      _menuItems = data;
      _menuItems.forEach((item) {
        _quantities[item['id']] = 0;
      });
    });
  }

  void _addItem(int id) {
    setState(() {
      _quantities[id] = (_quantities[id] ?? 0) + 1;
    });
  }

  void _removeItem(int id) {
    setState(() {
      if ((_quantities[id] ?? 0) > 0) {
        _quantities[id] = _quantities[id]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Menu'),
        centerTitle: true,
      ),
      body: _menuItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('₹${item['price']} • ${item['description']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _removeItem(item['id']),
                        ),
                        Text('${_quantities[item['id']]}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _addItem(item['id']),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/menu/details', arguments: item);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/cart', arguments: {
          "items": _menuItems,
          "quantities": _quantities,
        }),
        backgroundColor: Colors.red,
        icon: Icon(Icons.shopping_cart),
        label: Text('Cart'),
      ),
    );
  }
}
