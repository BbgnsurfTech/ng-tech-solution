# AgroConnect360 - Development Guide for Claude

This document provides context for AI assistants (Claude) working on the AgroConnect360 Flutter application.

## Project Overview

**AgroConnect360** is a comprehensive agriculture value chain platform built with Flutter, targeting Nigerian farmers, buyers, input dealers, and service providers. The app is based on extensive market research showing a ₦3-5 billion ($4-6 million) annual revenue potential.

## Current Project Status

### Completed Features ✅

1. **Authentication System**
   - Welcome screen with feature highlights
   - Login/Signup with form validation
   - User type selection (Farmer, Buyer, Input Dealer, Service Provider)

2. **State Management (Provider Pattern)**
   - `AuthProvider`: User authentication and session management
   - `FarmProvider`: Farm and crop lifecycle management
   - `MarketplaceProvider`: Marketplace items with filtering
   - `FinanceProvider`: Wallet, transactions, and loans

3. **Farm Management**
   - Add Crop screen with comprehensive form validation
   - Crop tracking with lifecycle stages (planted → growing → harvesting → sold)
   - Farm details display with statistics
   - Weather and advisory integration

4. **Marketplace**
   - Item listing with category filtering
   - Item details screen with seller information
   - Contact seller options (call, message, email)
   - View tracking for listings

5. **Financial Services**
   - Real-time wallet balance
   - Transaction history
   - Loan application with calculator (₦10K - ₦5M)
   - Monthly repayment calculator
   - Instant loan approval simulation

6. **Weather & Advisory**
   - 7-day weather forecast
   - Current weather conditions
   - Farming advisories (planting, rainfall, pest alerts)
   - Seasonal best practices
   - Climate information

## Architecture

### Folder Structure
```
lib/
├── constants/           # App-wide constants, colors, strings, theme
│   ├── app_colors.dart
│   ├── app_strings.dart
│   └── app_theme.dart
├── models/             # Data models
│   ├── user_model.dart
│   ├── farm_model.dart
│   ├── crop_model.dart
│   └── marketplace_item_model.dart
├── providers/          # State management
│   ├── auth_provider.dart
│   ├── farm_provider.dart
│   ├── marketplace_provider.dart
│   └── finance_provider.dart
├── screens/            # UI screens
│   ├── auth/          # Authentication screens
│   ├── main/          # Main navigation screens
│   ├── farm/          # Farm feature screens
│   ├── marketplace/   # Marketplace feature screens
│   ├── finance/       # Finance feature screens
│   └── advisory/      # Advisory feature screens
├── widgets/           # Reusable UI components (to be added)
├── services/          # API services (to be added)
└── utils/             # Utility functions (to be added)
```

### Design Patterns

1. **State Management**: Provider pattern for reactive state updates
2. **Navigation**: MaterialPageRoute with context-based navigation
3. **Theming**: Material Design 3 with custom agriculture-themed colors
4. **Forms**: TextFormField with validators, date pickers, dropdowns
5. **Mock Data**: All providers initialize with realistic sample data

### Color Scheme
- Primary: Green (#2E7D32) - Agriculture theme
- Secondary: Orange (#F57C00) - Warmth and energy
- Accent: Teal (#00897B) - Trust and growth
- Success: Green (#4CAF50)
- Warning: Amber (#FFC107)
- Error: Red (#F44336)
- Info: Blue (#2196F3)

## Mock Data

The app initializes with:
- **3 sample crops** (Cocoa, Cassava, Maize)
- **5 marketplace items** (Seeds, Fertilizers, Produce, Equipment)
- **5 financial transactions**
- **₦125,450 initial wallet balance**
- **1 farm** (Green Valley Farm, 10 hectares)

## Key Features to Implement Next

### High Priority
1. **Add Marketplace Listing Screen**
   - Form to create new listings
   - Image upload placeholder
   - Category and pricing inputs

2. **Search Functionality**
   - Search bar in marketplace
   - Filter by price range, location, category

3. **Reusable Widget Components**
   - Custom buttons
   - Loading indicators
   - Empty state widgets
   - Error widgets

4. **Settings Screen**
   - Account settings
   - Notification preferences
   - Language selection
   - Privacy settings

5. **Notifications Screen**
   - Activity notifications
   - System alerts
   - Marketplace inquiries

### Medium Priority
6. **Analytics Dashboard with Charts**
   - Farm revenue charts (fl_chart)
   - Crop performance metrics
   - Expense breakdown

7. **Enhanced Crop Details**
   - Crop growth timeline
   - Disease detection placeholder
   - Harvest prediction

8. **Payment Integration Placeholder**
   - Payment gateway structure
   - Transaction confirmation flows

### Future Enhancements
- Real backend API integration
- SQLite local database
- Image upload with camera/gallery
- Google Maps integration for farm location
- Push notifications
- Offline mode with data sync
- Multi-language support (English, Yoruba, Hausa, Igbo)

## Development Guidelines

### Adding New Screens

1. Create screen file in appropriate directory
2. Import necessary providers
3. Use Provider.of or Consumer for state
4. Follow Material Design 3 guidelines
5. Add navigation from existing screens
6. Update README if it's a major feature

### Adding New Features

1. Update relevant Provider if needed
2. Create new models if required
3. Implement UI screens
4. Add form validation where applicable
5. Test navigation flow
6. Commit with descriptive message

### Code Style

- Use const constructors where possible
- Follow Flutter/Dart naming conventions
- Add comments for complex logic
- Use meaningful variable names
- Keep functions small and focused
- Validate all user inputs

### Git Workflow

- Branch: `claude/start-app-setup-011CUwwbSZ3PD3bnV9nqwXHC`
- Commit frequently with clear messages
- Push after completing features
- Use descriptive commit messages with features listed

## Testing Instructions

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build APK
flutter build apk

# Build for iOS (macOS only)
flutter build ios
```

## Important Notes

1. **No Backend Yet**: All data is mocked in providers
2. **No Authentication**: Login always succeeds with mock user
3. **No Real Payments**: All transactions are simulated
4. **No Image Upload**: Image handling shows placeholders
5. **No API Calls**: All operations are local

## Revenue Model Implementation

The app structure supports:
- Transaction fees (3-5% on marketplace sales)
- Loan interest (15% APR implemented)
- SaaS subscriptions (structure ready)
- Premium features (can be gated easily)

## Market Context

- Target: 40 million farmers in Nigeria
- Agriculture: 21% of Nigeria's GDP
- Revenue Potential: ₦3-5 billion annually by Year 3
- Investment Needed: $15M over 3 years
- Focus Crops: Cocoa, Cashew, Cassava, Yam, Rice, Maize

## Dependencies

Key packages used:
- `provider: ^6.1.2` - State management
- `google_fonts: ^6.2.1` - Typography
- `intl: any` - Date formatting
- `uuid: ^4.5.1` - ID generation
- `fl_chart: ^0.69.0` - Charts (not yet implemented)
- `image_picker: ^1.1.2` - Image selection
- `geolocator: ^13.0.2` - Location services
- `google_maps_flutter: ^2.10.0` - Maps

## Contact & Support

- Repository: https://github.com/BbgnsurfTech/ng-tech-solution
- Branch: `claude/start-app-setup-011CUwwbSZ3PD3bnV9nqwXHC`

## Last Updated

November 9, 2025 - Added loan application, weather advisory, and enhanced provider integration

---

**For Claude**: When continuing development, prioritize user experience, maintain clean architecture, and ensure all features align with the agricultural use case. Focus on practical features that Nigerian farmers would actually use.
