import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum InfoCardType {
  info,
  success,
  warning,
  error,
}

class InfoCard extends StatelessWidget {
  final String title;
  final String message;
  final InfoCardType type;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.message,
    this.type = InfoCardType.info,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(type);

    return Card(
      color: config.color.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                config.icon,
                color: config.color,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  _CardConfig _getConfig(InfoCardType type) {
    switch (type) {
      case InfoCardType.info:
        return _CardConfig(
          color: AppColors.info,
          icon: Icons.info_outline,
        );
      case InfoCardType.success:
        return _CardConfig(
          color: AppColors.success,
          icon: Icons.check_circle_outline,
        );
      case InfoCardType.warning:
        return _CardConfig(
          color: AppColors.warning,
          icon: Icons.warning_amber,
        );
      case InfoCardType.error:
        return _CardConfig(
          color: AppColors.error,
          icon: Icons.error_outline,
        );
    }
  }
}

class _CardConfig {
  final Color color;
  final IconData icon;

  _CardConfig({
    required this.color,
    required this.icon,
  });
}
