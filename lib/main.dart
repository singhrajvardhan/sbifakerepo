// main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
void main() {
  runApp(SBIDemoApp());
}
class SBIDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Bank of India',
      theme: ThemeData(
        primaryColor: Color(0xFF004c9c),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFfc6e04),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
