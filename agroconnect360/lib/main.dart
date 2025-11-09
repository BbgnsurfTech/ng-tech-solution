import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constants/app_theme.dart';
import 'constants/app_strings.dart';
import 'providers/auth_provider.dart';
import 'providers/farm_provider.dart';
import 'providers/marketplace_provider.dart';
import 'providers/finance_provider.dart';
import 'screens/auth/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const AgroConnect360App());
}

class AgroConnect360App extends StatelessWidget {
  const AgroConnect360App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => FarmProvider()..initializeMockData(),
        ),
        ChangeNotifierProvider(
          create: (_) => MarketplaceProvider()..initializeMockData(),
        ),
        ChangeNotifierProvider(
          create: (_) => FinanceProvider()..initializeMockData(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const WelcomeScreen(),
      ),
    );
  }
}
