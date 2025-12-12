import 'package:flutter/material.dart';

class DemSo extends StatefulWidget {
  const DemSo({super.key});

  @override
  State<DemSo> createState() => _DemSoState();
}

class _DemSoState extends State<DemSo> {
  int count = 0;
  Color bgColor = Colors.purple;

  void _giam() {
    setState(() {
      count--;
      bgColor = Colors.red;
    });
  }

  void _tang() {
    setState(() {
      count++;
      bgColor = Colors.green;
    });
  }

  void _datLai() {
    setState(() {
      count = 0;
      bgColor = Colors.purple;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ứng dụng đếm số',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Giá trị hiện tại',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 48,
                color: bgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _giam,
                  icon: Icon(Icons.remove),
                  label: Text('Giảm', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _datLai,
                  icon: Icon(Icons.refresh),
                  label: Text('Đặt lại', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _tang,
                  icon: Icon(Icons.add),
                  label: Text('Tăng', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
