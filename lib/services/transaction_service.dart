// transaction_service.dart
class TransactionService {
  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    return [
      {
        'description': 'Amazon India',
        'date': 'Today, 10:23 AM',
        'amount': -1500.00,
      },
      {
        'description': 'Salary Credit',
        'date': '28 Aug, 9:15 AM',
        'amount': 42000.00,
      },
      {
        'description': 'Electricity Bill',
        'date': '25 Aug, 3:45 PM',
        'amount': -2340.00,
      },
      {
        'description': 'Mobile Recharge',
        'date': '22 Aug, 7:30 PM',
        'amount': -499.00,
      },
      {
        'description': 'UPI Transfer',
        'date': '20 Aug, 2:15 PM',
        'amount': -2000.00,
      },
      {
        'description': 'Interest Credit',
        'date': '15 Aug, 6:30 AM',
        'amount': 345.67,
      },
    ];
  }
}