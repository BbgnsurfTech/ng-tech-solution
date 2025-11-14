import 'package:flutter/foundation.dart';

enum TransactionType {
  credit,
  debit,
}

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final TransactionType type;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });
}

class FinanceProvider with ChangeNotifier {
  double _walletBalance = 125450.0;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  double get walletBalance => _walletBalance;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get totalIncome => _transactions
      .where((t) => t.type == TransactionType.credit)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == TransactionType.debit)
      .fold(0.0, (sum, t) => sum + t.amount);

  // Initialize with mock data
  void initializeMockData() {
    _transactions = [
      Transaction(
        id: 'txn1',
        title: 'Payment Received',
        description: 'Cocoa Sale - John Doe',
        amount: 50000,
        type: TransactionType.credit,
        date: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Transaction(
        id: 'txn2',
        title: 'Input Purchase',
        description: 'Fertilizer - ABC Agro',
        amount: 18000,
        type: TransactionType.debit,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Transaction(
        id: 'txn3',
        title: 'Loan Disbursed',
        description: 'Input Financing',
        amount: 100000,
        type: TransactionType.credit,
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Transaction(
        id: 'txn4',
        title: 'Seeds Purchase',
        description: 'Premium Cassava Stems',
        amount: 25000,
        type: TransactionType.debit,
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Transaction(
        id: 'txn5',
        title: 'Produce Sale',
        description: 'Maize - Export Company',
        amount: 75000,
        type: TransactionType.credit,
        date: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];

    notifyListeners();
  }

  // Add funds
  Future<bool> addFunds(double amount) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _walletBalance += amount;

      _transactions.insert(
        0,
        Transaction(
          id: 'txn${DateTime.now().millisecondsSinceEpoch}',
          title: 'Funds Added',
          description: 'Wallet top-up',
          amount: amount,
          type: TransactionType.credit,
          date: DateTime.now(),
        ),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Withdraw funds
  Future<bool> withdrawFunds(double amount) async {
    if (amount > _walletBalance) {
      _errorMessage = 'Insufficient balance';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _walletBalance -= amount;

      _transactions.insert(
        0,
        Transaction(
          id: 'txn${DateTime.now().millisecondsSinceEpoch}',
          title: 'Withdrawal',
          description: 'Funds withdrawn',
          amount: amount,
          type: TransactionType.debit,
          date: DateTime.now(),
        ),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Apply for loan
  Future<bool> applyForLoan({
    required double amount,
    required int durationMonths,
    required String purpose,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulate loan approval
      _walletBalance += amount;

      _transactions.insert(
        0,
        Transaction(
          id: 'txn${DateTime.now().millisecondsSinceEpoch}',
          title: 'Loan Disbursed',
          description: purpose,
          amount: amount,
          type: TransactionType.credit,
          date: DateTime.now(),
        ),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Make payment
  Future<bool> makePayment({
    required String title,
    required String description,
    required double amount,
  }) async {
    if (amount > _walletBalance) {
      _errorMessage = 'Insufficient balance';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _walletBalance -= amount;

      _transactions.insert(
        0,
        Transaction(
          id: 'txn${DateTime.now().millisecondsSinceEpoch}',
          title: title,
          description: description,
          amount: amount,
          type: TransactionType.debit,
          date: DateTime.now(),
        ),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
