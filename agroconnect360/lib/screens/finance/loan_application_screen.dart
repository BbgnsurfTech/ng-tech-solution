import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/finance_provider.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});

  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _purposeController = TextEditingController();

  int _selectedDuration = 6; // months
  String _selectedLoanType = 'Input Financing';
  bool _isLoading = false;

  final _loanTypes = [
    'Input Financing',
    'Equipment Purchase',
    'Land Expansion',
    'Working Capital',
    'Emergency Fund',
  ];

  final _durations = [3, 6, 9, 12, 18, 24];

  @override
  void dispose() {
    _amountController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  double _calculateMonthlyRepayment() {
    if (_amountController.text.isEmpty) return 0;

    final amount = double.tryParse(_amountController.text) ?? 0;
    final interestRate = 0.15; // 15% annual interest
    final monthlyRate = interestRate / 12;

    // Simple calculation: amount + interest / months
    final totalWithInterest = amount * (1 + (interestRate * _selectedDuration / 12));
    return totalWithInterest / _selectedDuration;
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final financeProvider = Provider.of<FinanceProvider>(context, listen: false);
    final amount = double.parse(_amountController.text);

    final success = await financeProvider.applyForLoan(
      amount: amount,
      durationMonths: _selectedDuration,
      purpose: _purposeController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 32),
              const SizedBox(width: 12),
              const Text('Loan Approved!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Congratulations! Your loan has been approved and disbursed to your wallet.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loan Amount: ₦${amount.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Duration: $_selectedDuration months'),
                    const SizedBox(height: 8),
                    Text(
                      'Monthly Repayment: ₦${_calculateMonthlyRepayment().toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to previous screen
              },
              child: const Text('Done'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(financeProvider.errorMessage ?? 'Loan application failed'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Loan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Card(
                color: AppColors.info.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.info,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Loan Approval',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Get instant approval for loans up to ₦5,000,000. No collateral required for verified farmers.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Loan Type
              Text(
                'Loan Type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedLoanType,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                ),
                items: _loanTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLoanType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Loan Amount
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Loan Amount (₦)',
                  prefixIcon: Icon(Icons.money),
                  hintText: 'Enter amount needed',
                ),
                onChanged: (value) {
                  setState(() {}); // Refresh monthly repayment
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter loan amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Please enter a valid amount';
                  }
                  if (amount < 10000) {
                    return 'Minimum loan amount is ₦10,000';
                  }
                  if (amount > 5000000) {
                    return 'Maximum loan amount is ₦5,000,000';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Loan Duration
              Text(
                'Repayment Duration',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _durations.map((duration) {
                  final isSelected = _selectedDuration == duration;
                  return ChoiceChip(
                    label: Text('$duration months'),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedDuration = duration;
                      });
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.textWhite : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Purpose
              TextFormField(
                controller: _purposeController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Purpose of Loan',
                  prefixIcon: Icon(Icons.notes),
                  hintText: 'Briefly describe how you will use this loan',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe the purpose of this loan';
                  }
                  if (value.length < 10) {
                    return 'Please provide more details (minimum 10 characters)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Loan Summary Card
              if (_amountController.text.isNotEmpty)
                Card(
                  color: AppColors.primary.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loan Summary',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          'Loan Amount',
                          '₦${_amountController.text}',
                        ),
                        const Divider(),
                        _buildSummaryRow(
                          'Interest Rate',
                          '15% per annum',
                        ),
                        const Divider(),
                        _buildSummaryRow(
                          'Duration',
                          '$_selectedDuration months',
                        ),
                        const Divider(),
                        _buildSummaryRow(
                          'Monthly Repayment',
                          '₦${_calculateMonthlyRepayment().toStringAsFixed(2)}',
                          isHighlight: true,
                        ),
                        const Divider(),
                        _buildSummaryRow(
                          'Total Repayment',
                          '₦${(_calculateMonthlyRepayment() * _selectedDuration).toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // Terms and Conditions
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'By submitting this application, you agree to our terms and conditions. Loan approval is subject to verification of your farm and credit history.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _submitApplication,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.textWhite,
                          ),
                        ),
                      )
                    : const Text('Submit Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isHighlight ? 16 : 14,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlight ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: isHighlight ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
