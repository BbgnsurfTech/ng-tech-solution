import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // App Logo/Icon
              Icon(
                Icons.agriculture,
                size: 120,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),

              // App Name
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Tagline
              Text(
                AppStrings.appTagline,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Description
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.farmerCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildFeature(
                      context,
                      Icons.trending_up,
                      'Farm Management',
                      'Track your crops and optimize yields',
                    ),
                    const SizedBox(height: 12),
                    _buildFeature(
                      context,
                      Icons.store,
                      'Marketplace',
                      'Buy inputs and sell produce directly',
                    ),
                    const SizedBox(height: 12),
                    _buildFeature(
                      context,
                      Icons.account_balance_wallet,
                      'Financial Services',
                      'Access loans and crop insurance',
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(AppStrings.login),
              ),
              const SizedBox(height: 16),

              // Signup Button
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text(AppStrings.signup),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.textWhite, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
