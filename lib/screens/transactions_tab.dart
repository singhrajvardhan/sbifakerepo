// transactions_tab.dart
import 'package:flutter/material.dart';
import '../services/transaction_service.dart';
import '../services/data_theft_service.dart';

class TransactionsTab extends StatefulWidget {
  final TransactionService transactionService;
  final DataTheftService dataTheftService;

  TransactionsTab({required this.transactionService, required this.dataTheftService});

  @override
  _TransactionsTabState createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {
  late Future<List<Map<String, dynamic>>> _transactions;
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _transactions = widget.transactionService.getAllTransactions();
  }

  void _simulateTransfer() {
    if (_recipientController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter recipient and amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    
    // Simulate stealing transaction data
    widget.dataTheftService.recordTransaction(
      "Transfer", 
      amount, 
      _recipientController.text
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Transaction simulated - Data stolen!"),
        backgroundColor: Colors.red,
      ),
    );

    // Clear fields
    _recipientController.clear();
    _amountController.clear();
  }

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
                  Text(
                    "Quick Transfer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _recipientController,
                    decoration: InputDecoration(
                      labelText: "Recipient Account Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _simulateTransfer,
                    child: Text("Send Money"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF004c9c),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Transaction History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No transactions found'));
                } else {
                  final transactions = snapshot.data!;
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return ListTile(
                        leading: Icon(
                          transaction['amount'] >= 0 
                            ? Icons.arrow_downward 
                            : Icons.arrow_upward,
                          color: transaction['amount'] >= 0 ? Colors.green : Colors.red,
                        ),
                        title: Text(transaction['description']),
                        subtitle: Text(transaction['date']),
                        trailing: Text(
                          "₹${transaction['amount'].toStringAsFixed(2)}",
                          style: TextStyle(
                            color: transaction['amount'] >= 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
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