// lib/services/json_file_service.dart
import 'dart:convert';
import 'dart:html' as html;

class JsonFileService {
  static final JsonFileService _instance = JsonFileService._internal();
  factory JsonFileService() => _instance;
  JsonFileService._internal();

  List<Map<String, dynamic>> _allStolenData = [];

  Future<void> saveStolenData(Map<String, dynamic> data) async {
    try {
      // Add timestamp and unique ID
      final completeData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'timestamp': DateTime.now().toIso8601String(),
        'ip': _getSimulatedIP(),
        'userAgent': html.window.navigator.userAgent,
        'platform': html.window.navigator.platform,
        ...data,
      };

      _allStolenData.add(completeData);

      // Convert to JSON string
      final jsonString = jsonEncode(_allStolenData);

      // Create download link
      final blob = html.Blob([jsonString], 'application/json');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create download link (but don't auto-download)
      final link = html.AnchorElement()
        ..href = url
        ..download = 'stolen_data.json'
        ..style.display = 'none';
      
      html.document.body?.append(link);
      
      print('JSON data prepared for download. Total entries: ${_allStolenData.length}');
      
    } catch (e) {
      print('Error saving JSON data: $e');
    }
  }

  String _getSimulatedIP() {
    // Simulate different IP addresses for demo
    final ips = [
      '192.168.1.15',
      '192.168.1.20',
      '10.0.0.5',
      '172.16.0.10',
      '203.0.113.25'
    ];
    return ips[DateTime.now().second % ips.length];
  }

  Future<void> saveLoginData(String username, String password, bool rememberMe) async {
    final data = {
      'action': 'login',
      'username': username,
      'password': password,
      'rememberMe': rememberMe,
      'deviceInfo': 'Flutter Web App',
    };
    
    await saveStolenData(data);
  }

  Future<void> saveLogoutData() async {
    final data = {
      'action': 'logout',
      'sessionDuration': '${DateTime.now().difference(DateTime.now().subtract(Duration(minutes: 15))).inMinutes} minutes',
    };
    
    await saveStolenData(data);
  }

  Future<void> savePermissionsData() async {
    final data = {
      'action': 'permissions_granted',
      'permissions': ['SMS', 'Photos', 'Contacts', 'Location', 'Camera', 'Microphone'],
      'riskLevel': 'HIGH',
    };
    
    await saveStolenData(data);
  }

  Future<void> saveTransactionData(String type, double amount, String recipient) async {
    final data = {
      'action': 'transaction',
      'transactionType': type,
      'amount': amount,
      'recipient': recipient,
      'currency': 'INR',
      'status': 'completed',
    };
    
    await saveStolenData(data);
  }

  Future<void> saveOtpData(String otp, String source) async {
    final data = {
      'action': 'otp_captured',
      'otp': otp,
      'source': source,
      'captureMethod': 'SMS_Intercept',
      'riskLevel': 'CRITICAL',
    };
    
    await saveStolenData(data);
  }

  String getStolenDataJson() {
    return jsonEncode(_allStolenData);
  }

  List<Map<String, dynamic>> getAllStolenData() {
    return List.from(_allStolenData);
  }

  void clearStolenData() {
    _allStolenData.clear();
  }

  Future<void> downloadJsonFile() async {
    try {
      final jsonString = jsonEncode(_allStolenData);
      final blob = html.Blob([jsonString], 'application/json');
      final url = html.Url.createObjectUrlFromBlob(blob);
      
      final link = html.AnchorElement()
        ..href = url
        ..download = 'sbi_stolen_data_${DateTime.now().millisecondsSinceEpoch}.json';
      
      // Simulate click to download
      link.click();
      
      // Clean up the URL object
      html.Url.revokeObjectUrl(url);
      
      print('JSON file downloaded with ${_allStolenData.length} entries');
    } catch (e) {
      print('Error downloading JSON file: $e');
    }
  }

  // Alternative method that doesn't modify DOM
  Future<void> downloadJsonFileAlternative() async {
    try {
      final jsonString = jsonEncode(_allStolenData);
      final bytes = utf8.encode(jsonString);
      final blob = html.Blob([bytes], 'application/json');
      final url = html.Url.createObjectUrlFromBlob(blob);
      
      final link = html.AnchorElement()
        ..href = url
        ..download = 'sbi_stolen_data_${DateTime.now().millisecondsSinceEpoch}.json'
        ..style.display = 'none';
      
      // Temporarily add to body, click, then remove
      html.document.body?.children.add(link);
      link.click();
      Future.delayed(Duration(milliseconds: 100), () {
        link.remove();
        html.Url.revokeObjectUrl(url);
      });
      
      print('JSON file downloaded with ${_allStolenData.length} entries');
    } catch (e) {
      print('Error downloading JSON file: $e');
    }
  }
}