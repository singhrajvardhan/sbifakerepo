// dashboard_screen.dart
import 'package:flutter/material.dart';
import '../services/account_service.dart';
import '../services/transaction_service.dart';
import '../services/data_theft_service.dart';
import 'accounts_tab.dart';
import 'transactions_tab.dart';
import 'profile_tab.dart';
import 'stolen_data_tab.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  final AccountService _accountService = AccountService();
  final TransactionService _transactionService = TransactionService();
  final DataTheftService _dataTheftService = DataTheftService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.account_balance, color: Colors.white),
              SizedBox(width: 10),
              Text("State Bank of India"),
            ],
          ),
          backgroundColor: Color(0xFF004c9c),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.account_balance_wallet), text: "Accounts"),
              Tab(icon: Icon(Icons.history), text: "Transactions"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
              Tab(icon: Icon(Icons.security), text: "Data View"),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _dataTheftService.recordLogout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            AccountsTab(accountService: _accountService),
            TransactionsTab(
              transactionService: _transactionService, 
              dataTheftService: _dataTheftService
            ),
            ProfileTab(),
            StolenDataTab(dataTheftService: _dataTheftService),
          ],
        ),
      ),
    );
  }
}