import 'package:flutter/foundation.dart';
import '../models/marketplace_item_model.dart';

class MarketplaceProvider with ChangeNotifier {
  List<MarketplaceItemModel> _items = [];
  bool _isLoading = false;
  String? _errorMessage;
  ItemCategory? _selectedCategory;

  List<MarketplaceItemModel> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ItemCategory? get selectedCategory => _selectedCategory;

  List<MarketplaceItemModel> get filteredItems {
    if (_selectedCategory == null) {
      return _items;
    }
    return _items.where((item) => item.category == _selectedCategory).toList();
  }

  List<MarketplaceItemModel> get myListings {
    // In real app, filter by current user ID
    return _items.take(2).toList();
  }

  // Initialize with mock data
  void initializeMockData() {
    _items = [
      MarketplaceItemModel(
        id: 'item1',
        sellerId: 'seller1',
        sellerName: 'ABC Seeds Ltd',
        title: 'Improved Cassava Stems',
        description: 'High-yield cassava varieties resistant to diseases. Perfect for commercial farming.',
        category: ItemCategory.seeds,
        price: 5000,
        priceUnit: 'bundle',
        quantity: 100,
        quantityUnit: 'bundles',
        location: 'Ibadan',
        state: 'Oyo',
        lga: 'Ibadan North',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        views: 45,
        inquiries: 12,
      ),
      MarketplaceItemModel(
        id: 'item2',
        sellerId: 'seller2',
        sellerName: 'FarmEquip Nigeria',
        title: 'NPK Fertilizer 15:15:15',
        description: 'Premium quality NPK fertilizer for all crops. Guaranteed authentic.',
        category: ItemCategory.fertilizers,
        price: 18000,
        priceUnit: '50kg bag',
        quantity: 500,
        quantityUnit: 'bags',
        location: 'Kano',
        state: 'Kano',
        lga: 'Kano Municipal',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        views: 89,
        inquiries: 23,
      ),
      MarketplaceItemModel(
        id: 'item3',
        sellerId: 'seller3',
        sellerName: 'Farmer John',
        title: 'Fresh Cocoa Beans',
        description: 'Premium quality dried cocoa beans for export. Grade A quality.',
        category: ItemCategory.produce,
        price: 1200,
        priceUnit: 'kg',
        quantity: 2000,
        quantityUnit: 'kg',
        location: 'Akure',
        state: 'Ondo',
        lga: 'Akure South',
        isNegotiable: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        views: 156,
        inquiries: 45,
      ),
      MarketplaceItemModel(
        id: 'item4',
        sellerId: 'seller4',
        sellerName: 'AgriTech Solutions',
        title: 'Irrigation System - Drip Kit',
        description: 'Complete drip irrigation system for 1 hectare. Water efficient.',
        category: ItemCategory.equipment,
        price: 250000,
        priceUnit: 'complete set',
        quantity: 10,
        quantityUnit: 'sets',
        location: 'Lagos',
        state: 'Lagos',
        lga: 'Ikeja',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        views: 234,
        inquiries: 67,
      ),
      MarketplaceItemModel(
        id: 'item5',
        sellerId: 'seller5',
        sellerName: 'Green Farms Ltd',
        title: 'Fresh Yam Tubers',
        description: 'Large white yam tubers. Fresh from the farm.',
        category: ItemCategory.produce,
        price: 800,
        priceUnit: 'tuber',
        quantity: 500,
        quantityUnit: 'tubers',
        location: 'Enugu',
        state: 'Enugu',
        isNegotiable: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        views: 78,
        inquiries: 19,
      ),
    ];

    notifyListeners();
  }

  // Set category filter
  void setCategory(ItemCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Add new listing
  Future<bool> addListing(MarketplaceItemModel item) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _items.insert(0, item);
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

  // Update listing
  Future<bool> updateListing(MarketplaceItemModel updatedItem) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final index = _items.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        _items[index] = updatedItem;
      }
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

  // Delete listing
  Future<bool> deleteListing(String itemId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _items.removeWhere((item) => item.id == itemId);
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

  // Get item by ID
  MarketplaceItemModel? getItemById(String itemId) {
    try {
      return _items.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }

  // Increment views
  void incrementViews(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _items[index] = _items[index].copyWith(views: _items[index].views + 1);
      notifyListeners();
    }
  }

  // Search items
  List<MarketplaceItemModel> searchItems(String query) {
    if (query.isEmpty) return _items;

    return _items.where((item) {
      return item.title.toLowerCase().contains(query.toLowerCase()) ||
             item.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
