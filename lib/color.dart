import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColorChangerScreen(),
    );
  }
}

class ColorChangerScreen extends StatefulWidget {
  const ColorChangerScreen({super.key});

  @override
  State<ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  final List<Map<String, dynamic>> _colorData = [
    {'color': Colors.purple, 'name': 'Tím'},
    {'color': Colors.red, 'name': 'Đỏ'},
    {'color': Colors.blue, 'name': 'Xanh Dương'},
    {'color': Colors.green, 'name': 'Xanh Lá'},
    {'color': Colors.orange, 'name': 'Cam'},
    {'color': Colors.pink, 'name': 'Hồng'},
    {'color': Colors.teal, 'name': 'Xanh Ngọc'},
    {'color': Colors.amber, 'name': 'Vàng Nghệ'},
    {'color': Colors.black, 'name': 'Đen'},
    {'color': Colors.brown, 'name': 'Nâu'},
  ];

  late Map<String, dynamic> _currentColor;
  late Map<String, dynamic> _previousColor;

  @override
  void initState() {
    super.initState();
    _currentColor = _colorData[0];
    _previousColor = _colorData[0];
  }

  void _changeColor() {
    setState(() {
      _previousColor = _currentColor;

      final random = Random();
      Map<String, dynamic> newColor;

      do {
        newColor = _colorData[random.nextInt(_colorData.length)];
      } while (newColor == _currentColor);

      _currentColor = newColor;
    });
  }

  void _resetColor() {
    setState(() {
      _currentColor = _previousColor;
    });
  }

  Color _getTextColor() {
    return _currentColor['color'] == Colors.black ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ứng dụng Đổi màu",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: _currentColor['color'],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Màu hiện tại",
              style: TextStyle(
                fontSize: 24,
                color: _getTextColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _currentColor['name'],
              style: TextStyle(
                fontSize: 40,
                color: _getTextColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _changeColor,
                  icon: const Icon(Icons.palette),
                  label: const Text("Đổi màu"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _currentColor['color'],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _resetColor,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Đặt lại"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _currentColor['color'],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
