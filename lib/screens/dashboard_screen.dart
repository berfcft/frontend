import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isOn = false;

  void _togglePower() {
    setState(() {
      isOn = !isOn;
    });
  }

  void _scheduleTimer() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Timer set for \${selectedTime.format(context)}")),
        );
      }
    });
  }

  void _showUserMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Log Out', style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
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
        title: const Text('DASHBOARD', style: TextStyle(color: Colors.greenAccent)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.greenAccent),
            onPressed: _showUserMenu,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _statusCard(),
            const SizedBox(height: 16),
            _dataCircleRow(),
            const SizedBox(height: 16),
            _onOffButton(),
            const SizedBox(height: 16),
            _bottomStatusRow(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(context, 0),
    );
  }

  Widget _statusCard() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: const [
          Icon(Icons.battery_charging_full, color: Colors.greenAccent, size: 48),
          SizedBox(height: 8),
          Text('CAPACITY', style: TextStyle(color: Colors.greenAccent)),
          Text('50%', style: TextStyle(color: Colors.white)),
        ],
      ),
      GestureDetector(
        onTap: _scheduleTimer,
        child: Column(
          children: const [
            Icon(Icons.access_time, color: Colors.greenAccent, size: 48),
            SizedBox(height: 8),
            Text('ESTIMATED TIME', style: TextStyle(color: Colors.greenAccent)),
            Text('7H:20M', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    ],
  );

  Widget _dataCircle(String label, String value) => Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(colors: [Colors.teal, Colors.lightGreenAccent]),
        ),
        child: Text(label, style: const TextStyle(color: Colors.black)),
      ),
      const SizedBox(height: 8),
      Text(value, style: const TextStyle(color: Colors.white)),
    ],
  );

  Widget _dataCircleRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _dataCircle('Voltage', '12.55V'),
      _dataCircle('Current', '1.71A'),
    ],
  );

  Widget _onOffButton() => Center(
    child: IconButton(
      icon: Icon(
        Icons.power_settings_new,
        color: isOn ? Colors.greenAccent : Colors.grey,
        size: 48,
      ),
      onPressed: _togglePower,
    ),
  );

  Widget _bottomStatusRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _bottomStatusBox(Icons.thermostat, 'Temperature', '38.7°C'),
      _bottomStatusBox(Icons.bolt, 'Power', '120W'),
    ],
  );

  Widget _bottomStatusBox(IconData icon, String label, String value) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.orangeAccent),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Text(value, style: const TextStyle(color: Colors.greenAccent)),
          ],
        )
      ],
    ),
  );

  Widget _bottomNavBar(BuildContext context, int selectedIndex) => BottomNavigationBar(
    currentIndex: selectedIndex,
    backgroundColor: Colors.grey[900],
    selectedItemColor: Colors.greenAccent,
    unselectedItemColor: Colors.white54,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.battery_charging_full), label: 'Dashboard'),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Charts'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ],
    onTap: (index) {
      if (index == selectedIndex) return;
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
  );
}
