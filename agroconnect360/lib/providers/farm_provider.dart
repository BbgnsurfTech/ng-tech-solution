import 'package:flutter/foundation.dart';
import '../models/farm_model.dart';
import '../models/crop_model.dart';

class FarmProvider with ChangeNotifier {
  List<FarmModel> _farms = [];
  List<CropModel> _crops = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<FarmModel> get farms => _farms;
  List<CropModel> get crops => _crops;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  FarmModel? get primaryFarm => _farms.isNotEmpty ? _farms.first : null;

  List<CropModel> get activeCrops => _crops.where(
    (crop) => crop.status != CropStatus.sold && crop.status != CropStatus.harvested
  ).toList();

  int get totalActiveCrops => activeCrops.length;

  double get totalFarmSize => _farms.fold(
    0.0,
    (sum, farm) => sum + farm.farmSize
  );

  // Initialize with mock data
  void initializeMockData() {
    _farms = [
      FarmModel(
        id: 'farm1',
        farmerId: 'user123',
        farmName: 'Green Valley Farm',
        farmSize: 10.0,
        sizeUnit: 'hectares',
        location: 'Abeokuta, Ogun State',
        latitude: 7.1557,
        longitude: 3.3456,
        soilType: 'Loamy',
        state: 'Ogun',
        lga: 'Abeokuta South',
        createdAt: DateTime.now(),
      ),
    ];

    _crops = [
      CropModel(
        id: 'crop1',
        farmId: 'farm1',
        farmerId: 'user123',
        cropName: 'Cocoa',
        cropType: CropType.cocoa,
        areaPlanted: 2.5,
        plantingDate: DateTime.now().subtract(const Duration(days: 60)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 120)),
        status: CropStatus.growing,
        estimatedYield: 1500,
        yieldUnit: 'kg',
        createdAt: DateTime.now(),
      ),
      CropModel(
        id: 'crop2',
        farmId: 'farm1',
        farmerId: 'user123',
        cropName: 'Cassava',
        cropType: CropType.cassava,
        areaPlanted: 3.0,
        plantingDate: DateTime.now().subtract(const Duration(days: 30)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 270)),
        status: CropStatus.planted,
        estimatedYield: 5000,
        yieldUnit: 'kg',
        createdAt: DateTime.now(),
      ),
      CropModel(
        id: 'crop3',
        farmId: 'farm1',
        farmerId: 'user123',
        cropName: 'Maize',
        cropType: CropType.maize,
        areaPlanted: 1.5,
        plantingDate: DateTime.now().subtract(const Duration(days: 45)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 75)),
        status: CropStatus.flowering,
        estimatedYield: 800,
        yieldUnit: 'kg',
        createdAt: DateTime.now(),
      ),
    ];

    notifyListeners();
  }

  // Add new farm
  Future<bool> addFarm(FarmModel farm) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _farms.add(farm);
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

  // Add new crop
  Future<bool> addCrop(CropModel crop) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _crops.add(crop);
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

  // Update crop
  Future<bool> updateCrop(CropModel updatedCrop) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final index = _crops.indexWhere((crop) => crop.id == updatedCrop.id);
      if (index != -1) {
        _crops[index] = updatedCrop;
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

  // Delete crop
  Future<bool> deleteCrop(String cropId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _crops.removeWhere((crop) => crop.id == cropId);
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

  // Get crops for a specific farm
  List<CropModel> getCropsForFarm(String farmId) {
    return _crops.where((crop) => crop.farmId == farmId).toList();
  }

  // Get crop by ID
  CropModel? getCropById(String cropId) {
    try {
      return _crops.firstWhere((crop) => crop.id == cropId);
    } catch (e) {
      return null;
    }
  }
}
