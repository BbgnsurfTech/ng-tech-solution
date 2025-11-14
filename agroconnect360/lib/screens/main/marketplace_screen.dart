import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../models/marketplace_item_model.dart';
import '../../providers/marketplace_provider.dart';
import '../marketplace/item_details_screen.dart';
import '../marketplace/add_listing_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final _sampleItems = [
    MarketplaceItemModel(
      id: '1',
      sellerId: 'seller1',
      sellerName: 'ABC Seeds Ltd',
      title: 'Improved Cassava Stems',
      description: 'High-yield cassava varieties resistant to diseases',
      category: ItemCategory.seeds,
      price: 5000,
      priceUnit: 'bundle',
      quantity: 100,
      quantityUnit: 'bundles',
      location: 'Ibadan',
      state: 'Oyo',
      createdAt: DateTime.now(),
      views: 45,
      inquiries: 12,
    ),
    MarketplaceItemModel(
      id: '2',
      sellerId: 'seller2',
      sellerName: 'FarmEquip Nigeria',
      title: 'NPK Fertilizer 15:15:15',
      description: 'Premium quality NPK fertilizer for all crops',
      category: ItemCategory.fertilizers,
      price: 18000,
      priceUnit: '50kg bag',
      quantity: 500,
      quantityUnit: 'bags',
      location: 'Kano',
      state: 'Kano',
      createdAt: DateTime.now(),
      views: 89,
      inquiries: 23,
    ),
    MarketplaceItemModel(
      id: '3',
      sellerId: 'seller3',
      sellerName: 'Farmer John',
      title: 'Fresh Cocoa Beans',
      description: 'Premium quality dried cocoa beans for export',
      category: ItemCategory.produce,
      price: 1200,
      priceUnit: 'kg',
      quantity: 2000,
      quantityUnit: 'kg',
      location: 'Akure',
      state: 'Ondo',
      isNegotiable: true,
      createdAt: DateTime.now(),
      views: 156,
      inquiries: 45,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    var filteredItems = marketplaceProvider.filteredItems;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredItems = marketplaceProvider.searchItems(_searchQuery);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.marketplace),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Category Filter
          Container(
            height: 60,
            color: AppColors.surface,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildCategoryChip('All', null),
                _buildCategoryChip('Seeds', ItemCategory.seeds),
                _buildCategoryChip('Fertilizers', ItemCategory.fertilizers),
                _buildCategoryChip('Produce', ItemCategory.produce),
                _buildCategoryChip('Equipment', ItemCategory.equipment),
                _buildCategoryChip('Services', ItemCategory.services),
              ],
            ),
          ),

          // Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return _buildMarketplaceItem(context, filteredItems[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddListingScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Sell Item'),
      ),
    );
  }

  Widget _buildCategoryChip(String label, ItemCategory? category) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context, listen: false);
    final isSelected = marketplaceProvider.selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          marketplaceProvider.setCategory(selected ? category : null);
        },
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.textWhite : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildMarketplaceItem(BuildContext context, MarketplaceItemModel item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailsScreen(itemId: item.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item Image Placeholder
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: _getCategoryColor(item.category).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getCategoryIcon(item.category),
                  size: 50,
                  color: _getCategoryColor(item.category),
                ),
              ),
              const SizedBox(width: 16),

              // Item Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        if (item.isNegotiable)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.info.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Negotiable',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.info,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.formattedPrice,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${item.location}, ${item.state}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.visibility,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${item.views}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter & Sort',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.sort, color: AppColors.primary),
              title: const Text('Sort by Price: Low to High'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sorting feature coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sort, color: AppColors.primary),
              title: const Text('Sort by Price: High to Low'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sorting feature coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.date_range, color: AppColors.primary),
              title: const Text('Sort by Date: Newest First'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sorting feature coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: AppColors.primary),
              title: const Text('Filter by Location'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Location filter coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
