import 'package:flutter/material.dart';

class CustomerProfileScreen extends StatefulWidget {
  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool isEditing = false;

  final TextEditingController _emailController =
      TextEditingController(text: 'john.doe@example.com');
  final TextEditingController _contactController =
      TextEditingController(text: '9876543210');
  final TextEditingController _addressController =
      TextEditingController(text: '123, MG Road, Bangalore, India');

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: toggleEditing,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildField("Email ID", _emailController),
            SizedBox(height: 16),
            buildField("Contact Number", _contactController),
            SizedBox(height: 16),
            buildField("Address", _addressController, maxLines: 2),
          ],
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditing,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: !isEditing,
        fillColor: isEditing ? Colors.white : Colors.grey[200],
      ),
      style: TextStyle(fontSize: 16),
    );
  }
}
