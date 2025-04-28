import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int selectedHistory = 0; // 0 = Voltage, 1 = Current, 2 = Temperature

  void _onHistorySelect(int index) {
    setState(() {
      selectedHistory = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('CHARTS', style: TextStyle(color: Colors.greenAccent)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sectionTitle('REAL TIME CURVE'),
            const SizedBox(height: 8),
            _infoRow('Voltage', '12.55V', 'Current', '1.71A', 'Temperature', '38.7°C'),
            const SizedBox(height: 12),
            _chartPlaceholder(),
            const SizedBox(height: 24),
            _sectionTitle('HISTORY CURVE'),
            const SizedBox(height: 8),
            _historyLegend(),
            const SizedBox(height: 12),
            _chartPlaceholder(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(context, 1),
    );
  }

  Widget _sectionTitle(String text) => Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.teal, Colors.lightGreenAccent],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
  );

  Widget _infoRow(String t1, String v1, String t2, String v2, String t3, String v3) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _infoBox(t1, v1),
      _infoBox(t2, v2),
      _infoBox(t3, v3),
    ],
  );

  Widget _infoBox(String title, String value) => Column(
    children: [
      Text(title, style: const TextStyle(color: Colors.greenAccent)),
      Text(value, style: const TextStyle(color: Colors.white)),
    ],
  );

  Widget _chartPlaceholder() => SizedBox(
    height: 150,
    child: LineChart(
      LineChartData(
        backgroundColor: Colors.white12,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 12.0),
              FlSpot(1, 12.2),
              FlSpot(2, 12.3),
              FlSpot(3, 12.5),
              FlSpot(4, 12.4),
            ],
            isCurved: true,
            color: Colors.greenAccent,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          )
        ],
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    ),
  );

  Widget _historyLegend() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ChoiceChip(
        label: const Text('VOLTAGE'),
        selected: selectedHistory == 0,
        onSelected: (_) => _onHistorySelect(0),
        selectedColor: Colors.greenAccent,
      ),
      ChoiceChip(
        label: const Text('CURRENT'),
        selected: selectedHistory == 1,
        onSelected: (_) => _onHistorySelect(1),
        selectedColor: Colors.greenAccent,
      ),
      ChoiceChip(
        label: const Text('TEMPERATURE'),
        selected: selectedHistory == 2,
        onSelected: (_) => _onHistorySelect(2),
        selectedColor: Colors.greenAccent,
      ),
    ],
  );

  Widget _bottomNavBar(BuildContext context, int selectedIndex) => BottomNavigationBar(
    currentIndex: selectedIndex,
    backgroundColor: Colors.black,
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
