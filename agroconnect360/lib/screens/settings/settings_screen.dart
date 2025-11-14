import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../auth/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // User Profile Section
          Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.primary.withOpacity(0.1),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    user?.fullName.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(
                      fontSize: 32,
                      color: AppColors.textWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.fullName ?? 'User',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Chip(
                  label: Text(
                    user?.userType.name.toUpperCase() ?? 'USER',
                    style: const TextStyle(fontSize: 11),
                  ),
                  backgroundColor: AppColors.primary,
                  labelStyle: const TextStyle(color: AppColors.textWhite),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Account Settings
          _buildSectionHeader('Account'),
          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your personal information',
            onTap: () => _showComingSoon(context),
          ),
          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () => _showComingSoon(context),
          ),
          _SettingsTile(
            icon: Icons.verified_user_outlined,
            title: 'Verify Account',
            subtitle: 'Complete account verification',
            trailing: user?.isVerified == true
                ? const Icon(Icons.check_circle, color: AppColors.success)
                : null,
            onTap: () => _showComingSoon(context),
          ),

          const Divider(height: 1),

          // Preferences
          _buildSectionHeader('Preferences'),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notification settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsScreen(),
                ),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () => _showComingSoon(context),
          ),
          _SettingsTile(
            icon: Icons.location_on_outlined,
            title: 'Location',
            subtitle: user?.state ?? 'Not set',
            onTap: () => _showComingSoon(context),
          ),

          const Divider(height: 1),

          // App Settings
          _buildSectionHeader('App Settings'),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => _showComingSoon(context),
          ),
          _SettingsTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => _showComingSoon(context),
          ),
          _SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => _showComingSoon(context),
          ),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'Version 1.0.0',
            onTap: () => _showAboutDialog(context),
          ),

          const Divider(height: 1),

          // Danger Zone
          _buildSectionHeader('Danger Zone'),
          _SettingsTile(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account',
            titleColor: AppColors.error,
            onTap: () => _showDeleteAccountDialog(context),
          ),
          _SettingsTile(
            icon: Icons.logout,
            title: 'Logout',
            titleColor: AppColors.error,
            onTap: () => _showLogoutDialog(context, authProvider),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About AgroConnect360'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text(
              'AgroConnect360 is a comprehensive platform connecting Nigerian farmers with markets, financial services, and agricultural resources.',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              '© 2025 AgroConnect360. All rights reserved.',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion is not available in demo mode'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            child: const Text(
              'DELETE',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              authProvider.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false,
              );
            },
            child: const Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: titleColor ?? AppColors.textPrimary),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(fontSize: 13),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _marketplaceAlerts = true;
  bool _weatherAlerts = true;
  bool _priceAlerts = true;
  bool _harvestReminders = true;
  bool _loanUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Notification Channels'),
          _buildSwitchTile(
            title: 'Push Notifications',
            subtitle: 'Receive notifications on your device',
            value: _pushNotifications,
            onChanged: (value) => setState(() => _pushNotifications = value),
          ),
          _buildSwitchTile(
            title: 'Email Notifications',
            subtitle: 'Receive notifications via email',
            value: _emailNotifications,
            onChanged: (value) => setState(() => _emailNotifications = value),
          ),
          _buildSwitchTile(
            title: 'SMS Notifications',
            subtitle: 'Receive notifications via SMS',
            value: _smsNotifications,
            onChanged: (value) => setState(() => _smsNotifications = value),
          ),
          const Divider(height: 1),
          _buildSectionHeader('Notification Types'),
          _buildSwitchTile(
            title: 'Marketplace Alerts',
            subtitle: 'New messages, orders, and listings',
            value: _marketplaceAlerts,
            onChanged: (value) => setState(() => _marketplaceAlerts = value),
          ),
          _buildSwitchTile(
            title: 'Weather Alerts',
            subtitle: 'Severe weather warnings',
            value: _weatherAlerts,
            onChanged: (value) => setState(() => _weatherAlerts = value),
          ),
          _buildSwitchTile(
            title: 'Price Alerts',
            subtitle: 'Market price changes',
            value: _priceAlerts,
            onChanged: (value) => setState(() => _priceAlerts = value),
          ),
          _buildSwitchTile(
            title: 'Harvest Reminders',
            subtitle: 'Crop harvest notifications',
            value: _harvestReminders,
            onChanged: (value) => setState(() => _harvestReminders = value),
          ),
          _buildSwitchTile(
            title: 'Loan Updates',
            subtitle: 'Loan application and payment updates',
            value: _loanUpdates,
            onChanged: (value) => setState(() => _loanUpdates = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 13),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
    );
  }
}
