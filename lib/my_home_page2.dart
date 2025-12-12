import 'package:flutter/material.dart';

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bl1(),
              SizedBox(height: 20),
              bl2(),
              SizedBox(height: 20),
              bl3(),
              SizedBox(height: 30),
              bl4(),
              SizedBox(height: 5),
              Expanded(child: bl5()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bl1() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      IconButton(onPressed: () {}, icon: Icon(Icons.extension)),
    ],
  );
}

Widget bl2() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 28),
      children: <TextSpan>[
        TextSpan(
          text: 'Welcome,\n',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
        ),
        TextSpan(text: 'Charlie', style: TextStyle(fontSize: 40)),
      ],
    ),
  );
}

Widget bl3() {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Search',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: Icon(Icons.search),
    ),
  );
}

Widget bl4() {
  return SizedBox(
    child: Text(
      'Saved Places',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
  );
}

Widget bl5() {
  return GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    children: <Widget>[
      ClipRRect(
        child: Image.asset('lib/assets/img/Anh_nen_1.jpg', fit: BoxFit.cover),
      ),
      ClipRRect(
        child: Image.asset('lib/assets/img/Anh_nen_2.jpg', fit: BoxFit.cover),
      ),
      ClipRRect(
        child: Image.asset('lib/assets/img/hinh_nen_3.jpg', fit: BoxFit.cover),
      ),
      ClipRRect(
        child: Image.asset('lib/assets/img/Anh_nen.jpg', fit: BoxFit.cover),
      ),
    ],
  );
}
