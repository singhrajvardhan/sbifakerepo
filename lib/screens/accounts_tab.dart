import 'package:flutter/material.dart';
import '../services/account_service.dart';

class AccountsTab extends StatefulWidget {
  final AccountService accountService;

  AccountsTab({required this.accountService});

  @override
  _AccountsTabState createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  late Future<Map<String, dynamic>> _accountSummary;
  late Future<List<Map<String, dynamic>>> _recentTransactions;

  @override
  void initState() {
    super.initState();
    _accountSummary = widget.accountService.getAccountSummary();
    _recentTransactions = widget.accountService.getRecentTransactions();
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'account_balance':
        return Icons.account_balance;
      case 'lightbulb_outline':
        return Icons.lightbulb_outline;
      case 'phone_android':
        return Icons.phone_android;
      default:
        return Icons.receipt;
    }
  }

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account Summary",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          FutureBuilder<Map<String, dynamic>>(
            future: _accountSummary,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final account = snapshot.data!;
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account['accountName'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text("Account No: ${account['accountNumber']}"),
                        SizedBox(height: 15),
                        Text(
                          "Available Balance",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          "₹${account['balance'].toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 20),
          Text(
            "Recent Transactions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _recentTransactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final transactions = snapshot.data!;
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return ListTile(
                        leading: Icon(
                          _getIconFromString(transaction['icon']), 
                          color: _getColorFromString(transaction['color'])
                        ),
                        title: Text(transaction['description']),
                        subtitle: Text(transaction['date']),
                        trailing: Text(
                          "${transaction['amount'] >= 0 ? '+' : ''}₹${transaction['amount'].abs().toStringAsFixed(2)}",
                          style: TextStyle(
                            color: transaction['amount'] >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}