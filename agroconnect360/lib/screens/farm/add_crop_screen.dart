import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../models/crop_model.dart';
import '../../providers/farm_provider.dart';
import '../../providers/auth_provider.dart';

class AddCropScreen extends StatefulWidget {
  final String farmId;

  const AddCropScreen({super.key, required this.farmId});

  @override
  State<AddCropScreen> createState() => _AddCropScreenState();
}

class _AddCropScreenState extends State<AddCropScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cropNameController = TextEditingController();
  final _areaController = TextEditingController();
  final _estimatedYieldController = TextEditingController();
  final _notesController = TextEditingController();

  CropType _selectedCropType = CropType.cassava;
  DateTime _plantingDate = DateTime.now();
  DateTime? _expectedHarvestDate;
  String _sizeUnit = 'hectares';
  bool _isLoading = false;

  final _cropTypes = {
    CropType.cocoa: 'Cocoa',
    CropType.cashew: 'Cashew',
    CropType.cassava: 'Cassava',
    CropType.yam: 'Yam',
    CropType.rice: 'Rice',
    CropType.maize: 'Maize',
    CropType.vegetables: 'Vegetables',
    CropType.fruits: 'Fruits',
    CropType.other: 'Other',
  };

  @override
  void dispose() {
    _cropNameController.dispose();
    _areaController.dispose();
    _estimatedYieldController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isPlantingDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isPlantingDate ? _plantingDate : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isPlantingDate) {
          _plantingDate = picked;
        } else {
          _expectedHarvestDate = picked;
        }
      });
    }
  }

  Future<void> _saveCrop() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final farmProvider = Provider.of<FarmProvider>(context, listen: false);

    final newCrop = CropModel(
      id: const Uuid().v4(),
      farmId: widget.farmId,
      farmerId: authProvider.currentUser?.id ?? 'user123',
      cropName: _cropNameController.text.isEmpty
          ? _cropTypes[_selectedCropType]!
          : _cropNameController.text,
      cropType: _selectedCropType,
      areaPlanted: double.parse(_areaController.text),
      sizeUnit: _sizeUnit,
      plantingDate: _plantingDate,
      expectedHarvestDate: _expectedHarvestDate,
      status: CropStatus.planted,
      estimatedYield: _estimatedYieldController.text.isNotEmpty
          ? double.parse(_estimatedYieldController.text)
          : null,
      yieldUnit: 'kg',
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      createdAt: DateTime.now(),
    );

    final success = await farmProvider.addCrop(newCrop);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Crop added successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(farmProvider.errorMessage ?? 'Failed to add crop'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Crop'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Crop Type
              Text(
                'Crop Type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<CropType>(
                value: _selectedCropType,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.eco),
                ),
                items: _cropTypes.entries.map((entry) {
                  return DropdownMenuItem<CropType>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCropType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Crop Name (Optional)
              TextFormField(
                controller: _cropNameController,
                decoration: InputDecoration(
                  labelText: 'Custom Crop Name (Optional)',
                  prefixIcon: const Icon(Icons.edit),
                  hintText: _cropTypes[_selectedCropType],
                ),
              ),
              const SizedBox(height: 16),

              // Area Planted
              TextFormField(
                controller: _areaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Area Planted',
                  prefixIcon: Icon(Icons.landscape),
                  hintText: 'Enter area',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter area planted';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // Size Unit
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Hectares'),
                      value: 'hectares',
                      groupValue: _sizeUnit,
                      onChanged: (value) {
                        setState(() {
                          _sizeUnit = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Acres'),
                      value: 'acres',
                      groupValue: _sizeUnit,
                      onChanged: (value) {
                        setState(() {
                          _sizeUnit = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Planting Date
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: AppColors.primary),
                  title: const Text('Planting Date'),
                  subtitle: Text(
                    '${_plantingDate.day}/${_plantingDate.month}/${_plantingDate.year}',
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _selectDate(context, true),
                ),
              ),
              const SizedBox(height: 16),

              // Expected Harvest Date
              Card(
                child: ListTile(
                  leading: const Icon(Icons.event, color: AppColors.secondary),
                  title: const Text('Expected Harvest Date (Optional)'),
                  subtitle: Text(
                    _expectedHarvestDate != null
                        ? '${_expectedHarvestDate!.day}/${_expectedHarvestDate!.month}/${_expectedHarvestDate!.year}'
                        : 'Not set',
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _selectDate(context, false),
                ),
              ),
              const SizedBox(height: 16),

              // Estimated Yield
              TextFormField(
                controller: _estimatedYieldController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Estimated Yield (kg) - Optional',
                  prefixIcon: Icon(Icons.scale),
                  hintText: 'Enter estimated yield',
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  prefixIcon: Icon(Icons.notes),
                  hintText: 'Add any additional notes',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveCrop,
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
                    : const Text('Add Crop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
