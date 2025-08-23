import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                  SizedBox(height: 16),
                  Text("Raj Sharma", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Customer ID: Raj2025"),
                  SizedBox(height: 8),
                  Text("Email: raj.sharma@example.com"),
                  SizedBox(height: 8),
                  Text("Phone: +91 98XXXXX123"),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Security Warning"),
                  content: Text("This is a demonstration app showing how fake banking apps can steal your credentials. Always verify apps before entering sensitive information."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    )
                  ],
                ),
              );
            },
            child: Text("Show Security Warning"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,),
          ),
        ],
      ),
    );
  }
}