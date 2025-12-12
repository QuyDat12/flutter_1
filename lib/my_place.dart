import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [block1(), block2(), block3(), block4()]),
        ),
      ),
    );
  }
}

Widget block1() {
  var src =
      'https://images.unsplash.com/photo-1559586616-361e18714958?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  return Image.network(src);
}

Widget block2() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Day la sa mac sahara",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Nam o Bac Phi",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.star, size: 20, color: Colors.green),
            Text("41", style: TextStyle(fontSize: 24)),
          ],
        ),
      ],
    ),
  );
}

Widget block3() {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.call),
            Text("CALL", style: TextStyle(color: Colors.blue, fontSize: 20)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.route),
            Text("ROUTE", style: TextStyle(fontSize: 20, color: Colors.blue)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.share),
            Text("SHARE", style: TextStyle(fontSize: 20, color: Colors.blue)),
          ],
        ),
      ],
    ),
  );
}

Widget block4() {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20),
    child: Text(
      "Sa mạc Sahara là sa mạc nóng lớn nhất thế giới, trải dài khắp Bắc Phi với diện tích khoảng 9,2 triệu km², tương đương với diện tích Hoa Kỳ hoặc Trung Quốc. Đây là một vùng đất đa dạng với các cao nguyên đá, đồng bằng sỏi, các vùng muối, hồ nước mặn và cả những cồn cát khổng lồ. Sahara được hình thành bởi một quá trình sa mạc hóa bắt đầu khoảng 5.000 năm trước và có khí hậu cực kỳ khắc nghiệt, với nhiệt độ ban ngày cao và ban đêm có thể xuống thấp. ",
      style: TextStyle(fontSize: 14),
    ),
  );
}
