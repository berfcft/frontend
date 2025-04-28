
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/chart_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(BmsControlApp());
}

class BmsControlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMS Control',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/charts': (context) => ChartScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
