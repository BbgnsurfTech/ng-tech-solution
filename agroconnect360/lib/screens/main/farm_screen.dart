import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../models/crop_model.dart';
import '../../providers/farm_provider.dart';
import '../farm/add_crop_screen.dart';

class FarmScreen extends StatelessWidget {
  const FarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmProvider = Provider.of<FarmProvider>(context);
    final crops = farmProvider.activeCrops;
    final primaryFarm = farmProvider.primaryFarm;

    // Sample data for backward compatibility
    final sampleCrops = crops.isNotEmpty ? crops : [
      CropModel(
        id: '1',
        farmId: 'farm1',
        farmerId: 'farmer1',
        cropName: 'Cocoa',
        cropType: CropType.cocoa,
        areaPlanted: 2.5,
        plantingDate: DateTime.now().subtract(const Duration(days: 60)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 120)),
        status: CropStatus.growing,
        estimatedYield: 1500,
        createdAt: DateTime.now(),
      ),
      CropModel(
        id: '2',
        farmId: 'farm1',
        farmerId: 'farmer1',
        cropName: 'Cassava',
        cropType: CropType.cassava,
        areaPlanted: 3.0,
        plantingDate: DateTime.now().subtract(const Duration(days: 30)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 270)),
        status: CropStatus.planted,
        estimatedYield: 5000,
        createdAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myFarm),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Farm Info Card
            Card(
              color: AppColors.farmerCard,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.landscape,
                          size: 40,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Green Valley Farm',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Ogun State, Nigeria',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoItem(context, '10', 'Hectares'),
                        _buildDivider(),
                        _buildInfoItem(context, '5', 'Active Crops'),
                        _buildDivider(),
                        _buildInfoItem(context, 'Loamy', 'Soil Type'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Active Crops Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.activeCrops,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton.icon(
                  onPressed: () {
                    if (primaryFarm != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCropScreen(farmId: primaryFarm.id),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(AppStrings.addCrop),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Crops List
            ...sampleCrops.map((crop) => _buildCropCard(context, crop)),

            const SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context,
                    'Weather',
                    Icons.wb_sunny,
                    AppColors.warning,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    context,
                    'Advisory',
                    Icons.lightbulb_outline,
                    AppColors.info,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context,
                    'Disease Check',
                    Icons.bug_report,
                    AppColors.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    context,
                    'Analytics',
                    Icons.analytics,
                    AppColors.accent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (primaryFarm != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCropScreen(farmId: primaryFarm.id),
              ),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addCrop),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: AppColors.divider,
    );
  }

  Widget _buildCropCard(BuildContext context, CropModel crop) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getStatusColor(crop.status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.eco,
                    color: _getStatusColor(crop.status),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crop.cropName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${crop.areaPlanted} ${crop.sizeUnit}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(crop.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(crop.status),
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCropInfo(
                  context,
                  'Planted',
                  '${crop.daysSincePlanting} days ago',
                ),
                _buildCropInfo(
                  context,
                  'Harvest',
                  '${crop.daysUntilHarvest} days',
                ),
                _buildCropInfo(
                  context,
                  'Est. Yield',
                  '${crop.estimatedYield} ${crop.yieldUnit}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCropInfo(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(CropStatus status) {
    switch (status) {
      case CropStatus.planted:
        return AppColors.info;
      case CropStatus.growing:
        return AppColors.success;
      case CropStatus.flowering:
        return AppColors.warning;
      case CropStatus.harvesting:
        return AppColors.secondary;
      case CropStatus.harvested:
        return AppColors.accent;
      case CropStatus.sold:
        return AppColors.primary;
    }
  }

  String _getStatusText(CropStatus status) {
    return status.toString().split('.').last.toUpperCase();
  }
}
