// login_screen.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/data_theft_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final DataTheftService _dataTheftService = DataTheftService();
  bool _isLoading = false;
  bool _showDataTheft = false;
  Map<String, dynamic> _stolenData = {};
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill demo credentials
    _usernameController.text = "Raj2025";
    _passwordController.text = "Sbiraj2023";
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _showDataTheft = false;
    });

    try {
      // Simulate permissions request
      await _simulatePermissionsRequest();
      
      // Steal credentials and data
      final stolenData = await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      // Record additional stolen data
      _dataTheftService.recordLogin(
        _usernameController.text,
        _passwordController.text,
        _rememberMe,
      );

      setState(() {
        _stolenData = stolenData;
        _showDataTheft = true;
      });

      // Navigate to dashboard after showing theft info
      await Future.delayed(Duration(seconds: 3));
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Failed"),
          content: Text("For demonstration, use:\nUsername: Raj2025\nPassword: Sbiraj2023"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  Future<void> _simulatePermissionsRequest() async {
    // Simulate permission requests that fake apps typically make
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permissions Required"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("This app requires the following permissions:"),
            SizedBox(height: 10),
            Text("• Read SMS (to auto-read OTP)"),
            Text("• Access Photos/Media"),
            Text("• Access Contacts"),
            Text("• Access Location"),
            SizedBox(height: 10),
            Text("These permissions will be exploited to steal your data."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("DENY"),
          ),
          ElevatedButton(
            onPressed: () {
              _dataTheftService.recordPermissionsGranted();
              Navigator.pop(context);
            },
            child: Text("ALLOW ALL"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF004c9c),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF004c9c), Color(0xFF0077c0)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [



              // SBI Logo and Branding
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.account_balance,
                  size: 60,
                  color: Color(0xFF004c9c),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "State Bank of India",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Secure Banking",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              
              // Login Card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Net Banking Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004c9c),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Educational Demo - Data Theft Simulation",
                        style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          Text("Remember me"),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text("Forgot Password?"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _login,
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF004c9c),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 15),
                      Text(
                        "By logging in, you agree to the Terms of Service and acknowledge this is a demo app",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),



              
              // Data Theft Simulation Display
              if (_showDataTheft)
                Card(
                  color: Color(0xFFFFEBEE),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red),
                            SizedBox(width: 5),
                            Text(
                              "DATA THEFT SIMULATION ACTIVATED",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text("✓ Credentials Stored: ${_stolenData['username']}, ${_stolenData['password']}"),
                        Text("✓ Login Time: ${_stolenData['loginTime']}"),
                        Text("✓ Device Info: ${_stolenData['deviceInfo']}"),
                        Text("✓ IP Address: ${_stolenData['ip']}"),
                        Text("✓ Permissions Granted: Photos, SMS, Contacts, Location"),
                        SizedBox(height: 10),
                        Text(
                          "All data has been saved to device storage and would be transmitted to attackers in a real attack",
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}