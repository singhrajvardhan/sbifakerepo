class AccountService {
  Future<Map<String, dynamic>> getAccountSummary() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    return {
      'accountName': 'Primary Savings Account',
      'accountNumber': 'XXXX XXXX 4528',
      'balance': 54327.89,
    };
  }

  Future<List<Map<String, dynamic>>> getRecentTransactions() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    return [
      {
        'description': 'Amazon India',
        'date': 'Today, 10:23 AM',
        'amount': -1500.00,
        'icon': 'shopping_cart',
        'color': 'red',
      },
      {
        'description': 'Salary Credit',
        'date': '28 Aug, 9:15 AM',
        'amount': 42000.00,
        'icon': 'account_balance',
        'color': 'green',
      },
      {
        'description': 'Electricity Bill',
        'date': '25 Aug, 3:45 PM',
        'amount': -2340.00,
        'icon': 'lightbulb_outline',
        'color': 'red',
      },
      {
        'description': 'Mobile Recharge',
        'date': '22 Aug, 7:30 PM',
        'amount': -499.00,
        'icon': 'phone_android',
        'color': 'red',
      },
    ];
  }
}