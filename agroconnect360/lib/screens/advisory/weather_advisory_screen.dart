import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class WeatherAdvisoryScreen extends StatelessWidget {
  const WeatherAdvisoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather & Advisory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change location feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Weather Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ogun State',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Today, ${DateTime.now().day} ${_getMonthName(DateTime.now().month)}',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.wb_sunny,
                              size: 60,
                              color: AppColors.warning,
                            ),
                            Text(
                              'Sunny',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildWeatherDetail(Icons.thermostat, '28°C', 'Temperature'),
                        _buildWeatherDetail(Icons.water_drop, '65%', 'Humidity'),
                        _buildWeatherDetail(Icons.air, '12 km/h', 'Wind'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 7-Day Forecast
            Text(
              '7-Day Forecast',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return _buildForecastCard(
                    _getDayName(index),
                    _getWeatherIcon(index),
                    '${28 + index % 5}°C',
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Farming Advisory
            Text(
              'Farming Advisory',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildAdvisoryCard(
              'Planting Recommendation',
              'Excellent conditions for planting cassava this week. Soil moisture is optimal.',
              Icons.eco,
              AppColors.success,
            ),
            _buildAdvisoryCard(
              'Rainfall Alert',
              'Moderate rainfall expected in 3 days. Prepare your drainage systems.',
              Icons.umbrella,
              AppColors.info,
            ),
            _buildAdvisoryCard(
              'Pest Alert',
              'Increased pest activity due to humidity. Consider preventive spraying.',
              Icons.bug_report,
              AppColors.warning,
            ),
            const SizedBox(height: 24),

            // Best Practices
            Text(
              'Seasonal Best Practices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              child: ExpansionTile(
                leading: const Icon(Icons.lightbulb, color: AppColors.primary),
                title: const Text('Rainy Season Tips'),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '• Ensure proper drainage to prevent waterlogging\n'
                      '• Store fertilizers in dry places\n'
                      '• Monitor crops for fungal diseases\n'
                      '• Plan harvest schedules around heavy rains\n'
                      '• Maintain equipment to prevent rust',
                      style: TextStyle(height: 1.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ExpansionTile(
                leading: const Icon(Icons.wb_sunny, color: AppColors.warning),
                title: const Text('Dry Season Tips'),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '• Implement drip irrigation systems\n'
                      '• Mulch around plants to retain moisture\n'
                      '• Water early morning or late evening\n'
                      '• Monitor soil moisture regularly\n'
                      '• Consider drought-resistant crop varieties',
                      style: TextStyle(height: 1.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Climate Information
            Card(
              color: AppColors.accent.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Climate Advisory',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Based on historical data, this region typically experiences:\n\n'
                      '• Peak rainfall: June - September\n'
                      '• Best planting: April - May, September - October\n'
                      '• Dry season: November - March\n'
                      '• Average temperature: 25°C - 30°C',
                      style: TextStyle(height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildForecastCard(String day, IconData icon, String temp) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Icon(icon, color: AppColors.warning, size: 32),
            const SizedBox(height: 8),
            Text(
              temp,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvisoryCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(description),
        ),
        isThreeLine: true,
      ),
    );
  }

  String _getDayName(int index) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final now = DateTime.now();
    final day = now.add(Duration(days: index));
    return days[day.weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  IconData _getWeatherIcon(int index) {
    final icons = [
      Icons.wb_sunny,
      Icons.wb_cloudy,
      Icons.wb_sunny,
      Icons.cloud,
      Icons.wb_sunny,
      Icons.wb_cloudy,
      Icons.umbrella,
    ];
    return icons[index];
  }
}
