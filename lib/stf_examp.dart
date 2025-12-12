import 'package:flutter/material.dart';
import 'dart:math';

class Example extends StatefulWidget {
  Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Color bgColor = Colors.purple;
  String colorString = 'Purple';

  List<Color> lstColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
  ];

  List<String> lstColorString = ['Red', 'Green', 'Blue', 'Yellow', 'Pink'];

  void _changeColor() {
    var rand = Random();
    var numberRandom = rand.nextInt(lstColor.length);
    setState(() {
      bgColor = lstColor[numberRandom];
      colorString = lstColorString[numberRandom];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.color_lens),
        title: Text(
          'Ứng dụng đổi màu nền',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: bgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Màu hiện tại',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                colorString,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _changeColor,
                    icon: Icon(Icons.palette),
                    label: Text('Đổi màu'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.refresh),
                    label: Text('Đặt lại'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
