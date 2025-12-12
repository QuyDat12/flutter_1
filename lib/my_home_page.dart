import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(20, (index) => item()),
        ),
      ),
    );
  }
}

Widget item() {
  return Container(
    height: 120,
    margin: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: NetworkImage(
          'https://cdn.pixabay.com/photo/2022/11/08/06/05/read-7577787_640.jpg',
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'XML va Ung dung - Nhom 1',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('2025-2026.1.TIN4583.001', style: TextStyle(fontSize: 17)),
              ],
            ),
            Text('50 hoc vien', style: TextStyle(fontSize: 17)),
          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
      ],
    ),
  );
}
