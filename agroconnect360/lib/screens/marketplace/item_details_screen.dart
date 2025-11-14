import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../models/marketplace_item_model.dart';
import '../../providers/marketplace_provider.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String itemId;

  const ItemDetailsScreen({super.key, required this.itemId});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Increment views when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MarketplaceProvider>(context, listen: false)
          .incrementViews(widget.itemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    final item = marketplaceProvider.getItemById(widget.itemId);

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Item Not Found')),
        body: const Center(
          child: Text('This item is no longer available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Item Images (Placeholder)
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: _getCategoryColor(item.category).withOpacity(0.2),
              ),
              child: Center(
                child: Icon(
                  _getCategoryIcon(item.category),
                  size: 120,
                  color: _getCategoryColor(item.category),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      if (item.isNegotiable)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.info.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Negotiable',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.info,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    item.formattedPrice,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(item.category).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getCategoryIcon(item.category),
                          size: 16,
                          color: _getCategoryColor(item.category),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getCategoryName(item.category),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getCategoryColor(item.category),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),

                  // Details Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            context,
                            Icons.inventory,
                            'Quantity Available',
                            '${item.quantity} ${item.quantityUnit}',
                          ),
                          const Divider(),
                          _buildDetailRow(
                            context,
                            Icons.location_on,
                            'Location',
                            '${item.location}, ${item.state}',
                          ),
                          if (item.lga != null) ...[
                            const Divider(),
                            _buildDetailRow(
                              context,
                              Icons.place,
                              'LGA',
                              item.lga!,
                            ),
                          ],
                          const Divider(),
                          _buildDetailRow(
                            context,
                            Icons.calendar_today,
                            'Listed',
                            _formatDate(item.createdAt),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Seller Information
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primary.withOpacity(0.2),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Seller',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  item.sellerName,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              // TODO: Navigate to seller profile
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Seller profile coming soon'),
                                ),
                              );
                            },
                            child: const Text('View Profile'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Stats
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.visibility,
                                  color: AppColors.info,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${item.views}',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const Text(
                                  'Views',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.message,
                                  color: AppColors.secondary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${item.inquiries}',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const Text(
                                  'Inquiries',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80), // Space for bottom buttons
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement contact seller
                  _showContactOptions(context, item);
                },
                icon: const Icon(Icons.phone),
                label: const Text('Contact'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement buy now
                  _showBuyDialog(context, item);
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showContactOptions(BuildContext context, MarketplaceItemModel item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Contact ${item.sellerName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.primary),
              title: const Text('Call Seller'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Calling seller...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.message, color: AppColors.secondary),
              title: const Text('Send Message'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Messaging feature coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppColors.info),
              title: const Text('Email Seller'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening email...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBuyDialog(BuildContext context, MarketplaceItemModel item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Purchase Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item: ${item.title}'),
            const SizedBox(height: 8),
            Text('Price: ${item.formattedPrice}'),
            const SizedBox(height: 16),
            const Text(
              'Would you like to proceed with this purchase?',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Purchase feature coming soon'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(ItemCategory category) {
    switch (category) {
      case ItemCategory.seeds:
        return AppColors.success;
      case ItemCategory.fertilizers:
        return AppColors.warning;
      case ItemCategory.pesticides:
        return AppColors.error;
      case ItemCategory.equipment:
        return AppColors.info;
      case ItemCategory.produce:
        return AppColors.secondary;
      case ItemCategory.livestock:
        return AppColors.accent;
      case ItemCategory.services:
        return AppColors.primary;
      case ItemCategory.other:
        return AppColors.textSecondary;
    }
  }

  IconData _getCategoryIcon(ItemCategory category) {
    switch (category) {
      case ItemCategory.seeds:
        return Icons.eco;
      case ItemCategory.fertilizers:
        return Icons.science;
      case ItemCategory.pesticides:
        return Icons.bug_report;
      case ItemCategory.equipment:
        return Icons.build;
      case ItemCategory.produce:
        return Icons.shopping_basket;
      case ItemCategory.livestock:
        return Icons.pets;
      case ItemCategory.services:
        return Icons.handyman;
      case ItemCategory.other:
        return Icons.category;
    }
  }

  String _getCategoryName(ItemCategory category) {
    return category.toString().split('.').last.toUpperCase();
  }
}
