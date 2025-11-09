import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../constants/app_colors.dart';
import '../../models/marketplace_item_model.dart';
import '../../providers/marketplace_provider.dart';
import '../../providers/auth_provider.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _locationController = TextEditingController();

  ItemCategory _selectedCategory = ItemCategory.produce;
  String _priceUnit = 'kg';
  String _quantityUnit = 'kg';
  String _selectedState = 'Lagos';
  bool _isNegotiable = false;
  bool _isLoading = false;

  final _categories = {
    ItemCategory.seeds: 'Seeds',
    ItemCategory.fertilizers: 'Fertilizers',
    ItemCategory.pesticides: 'Pesticides',
    ItemCategory.equipment: 'Equipment',
    ItemCategory.produce: 'Produce',
    ItemCategory.livestock: 'Livestock',
    ItemCategory.services: 'Services',
  };

  final _priceUnits = ['kg', 'bag', 'bundle', 'piece', 'unit', 'ton', 'liter'];
  final _quantityUnits = ['kg', 'bags', 'bundles', 'pieces', 'units', 'tons', 'liters'];

  final _nigerianStates = [
    'Abia', 'Adamawa', 'Akwa Ibom', 'Anambra', 'Bauchi', 'Bayelsa', 'Benue',
    'Borno', 'Cross River', 'Delta', 'Ebonyi', 'Edo', 'Ekiti', 'Enugu',
    'Gombe', 'Imo', 'Jigawa', 'Kaduna', 'Kano', 'Katsina', 'Kebbi', 'Kogi',
    'Kwara', 'Lagos', 'Nasarawa', 'Niger', 'Ogun', 'Ondo', 'Osun', 'Oyo',
    'Plateau', 'Rivers', 'Sokoto', 'Taraba', 'Yobe', 'Zamfara', 'FCT'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submitListing() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context, listen: false);

    final newListing = MarketplaceItemModel(
      id: const Uuid().v4(),
      sellerId: authProvider.currentUser?.id ?? 'user123',
      sellerName: authProvider.currentUser?.fullName ?? 'Current User',
      title: _titleController.text,
      description: _descriptionController.text,
      category: _selectedCategory,
      price: double.parse(_priceController.text),
      priceUnit: _priceUnit,
      quantity: double.parse(_quantityController.text),
      quantityUnit: _quantityUnit,
      location: _locationController.text,
      state: _selectedState,
      isNegotiable: _isNegotiable,
      createdAt: DateTime.now(),
    );

    final success = await marketplaceProvider.addListing(newListing);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Listing added successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(marketplaceProvider.errorMessage ?? 'Failed to add listing'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Listing'),
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
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Create a listing to sell your produce or offer services to other farmers',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Category
              Text(
                'Category',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<ItemCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Item Title',
                  prefixIcon: Icon(Icons.title),
                  hintText: 'e.g., Fresh Cassava Stems',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item title';
                  }
                  if (value.length < 5) {
                    return 'Title must be at least 5 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Describe your item in detail',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  if (value.length < 20) {
                    return 'Description must be at least 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Price
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price (₦)',
                        prefixIcon: Icon(Icons.money),
                        hintText: '0.00',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid price';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _priceUnit,
                      decoration: const InputDecoration(
                        labelText: 'Per',
                      ),
                      items: _priceUnits.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _priceUnit = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Quantity
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity Available',
                        prefixIcon: Icon(Icons.inventory),
                        hintText: '0',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter quantity';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _quantityUnit,
                      decoration: const InputDecoration(
                        labelText: 'Unit',
                      ),
                      items: _quantityUnits.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _quantityUnit = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location/City',
                  prefixIcon: Icon(Icons.location_city),
                  hintText: 'e.g., Ibadan',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // State
              Text(
                'State',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedState,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.map),
                ),
                items: _nigerianStates.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Negotiable
              SwitchListTile(
                title: const Text('Price is Negotiable'),
                subtitle: const Text('Allow buyers to negotiate the price'),
                value: _isNegotiable,
                onChanged: (value) {
                  setState(() {
                    _isNegotiable = value;
                  });
                },
                activeColor: AppColors.primary,
              ),
              const SizedBox(height: 24),

              // Image Upload Placeholder
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Add Photos',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Photo upload coming soon',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _submitListing,
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
                    : const Text('Publish Listing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
