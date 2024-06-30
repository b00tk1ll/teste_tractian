import 'package:flutter/material.dart';
import 'package:tractian_teste/ui/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      home: const HomeScreen(),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
