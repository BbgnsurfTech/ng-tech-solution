import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful login
      _currentUser = UserModel(
        id: 'user123',
        fullName: 'Adebayo Ogunleye',
        email: email,
        phoneNumber: '08012345678',
        userType: UserType.farmer,
        createdAt: DateTime.now(),
        isVerified: true,
        state: 'Ogun',
        lga: 'Abeokuta South',
      );

      _isAuthenticated = true;
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

  // Signup
  Future<bool> signup({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required UserType userType,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful signup
      _currentUser = UserModel(
        id: 'user${DateTime.now().millisecondsSinceEpoch}',
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        userType: userType,
        createdAt: DateTime.now(),
        isVerified: false,
      );

      _isAuthenticated = true;
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

  // Logout
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Update user profile
  void updateUserProfile(UserModel updatedUser) {
    _currentUser = updatedUser;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
