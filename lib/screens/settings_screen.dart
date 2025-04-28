import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _lvpController = TextEditingController(text: '8.00');
  final TextEditingController _ovpController = TextEditingController(text: '20.00');
  final TextEditingController _ltpController = TextEditingController(text: '-20.0');
  final TextEditingController _oppController = TextEditingController(text: '34.0');
  final TextEditingController _otpController = TextEditingController(text: '70.0');
  final TextEditingController _reminderController = TextEditingController(text: '30');

  @override
  void dispose() {
    _lvpController.dispose();
    _ovpController.dispose();
    _ltpController.dispose();
    _oppController.dispose();
    _otpController.dispose();
    _reminderController.dispose();
    super.dispose();
  }

  Widget _buildSettingTile(String code, String title, TextEditingController controller, String unit) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: 22,
            child: Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.greenAccent),
              decoration: InputDecoration(
                isDense: true,
                suffixText: unit,
                suffixStyle: const TextStyle(color: Colors.greenAccent),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('SETTINGS', style: TextStyle(color: Colors.greenAccent)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _buildSettingTile('LVP', 'Low Voltage Protection', _lvpController, 'V'),
          _buildSettingTile('OVP', 'Over Voltage Protection', _ovpController, 'V'),
          _buildSettingTile('LTP', 'Low Temperature Protection', _ltpController, '°C'),
          _buildSettingTile('Low\nCap', 'Reminder', _reminderController, '%'),
          _buildSettingTile('OPP', 'Over Power Protection', _oppController, 'W'),
          _buildSettingTile('OTP', 'Over Temperature Protection', _otpController, '°C'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.battery_charging_full), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Charts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/charts');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}
