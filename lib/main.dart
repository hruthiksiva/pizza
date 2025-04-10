import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/menu_list_screen.dart';
import 'screens/menu_details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/order_status_screen.dart';
import 'screens/customer_profile_screen.dart';

void main() {
  runApp(PizzaOrderApp());
}

class PizzaOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Order App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/menu': (context) => MenuListScreen(),
        '/menu/details': (context) => MenuDetailsScreen(),
        '/cart': (context) => CartScreen(),
        '/payment': (context) => PaymentScreen(),
        '/order-status': (context) => OrderStatusScreen(),
        '/profile': (context) => CustomerProfileScreen(),
      },
    );
  }
}
