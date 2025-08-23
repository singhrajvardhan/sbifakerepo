import 'dart:convert';

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    if (username == "Raj2025" && password == "Sbiraj2023") {
      // Simulate data theft
      final stolenData = {
        'username': username,
        'password': password,
        'loginTime': DateTime.now().toIso8601String(),
        'deviceInfo': 'Flutter Demo App',
        'ip': '192.168.1.15 (simulated)',
      };

      // In a real scenario, this would be sent to a remote server
      print("Data stolen: ${json.encode(stolenData)}");
      
      return stolenData;
    } else {
      throw Exception('Login failed: Invalid credentials');
    }
  }
}