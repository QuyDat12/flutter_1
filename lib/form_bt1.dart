import 'package:flutter/material.dart';

class FormBt1 extends StatelessWidget {
  const FormBt1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form đăng nhập', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(child: FormDangNhap()),
    );
  }
}

class FormDangNhap extends StatefulWidget {
  const FormDangNhap({super.key});

  @override
  State<FormDangNhap> createState() => _FormDangNhapState();
}

class _FormDangNhapState extends State<FormDangNhap> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoadPass = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              label: Text('Tên người dùng'),
              hint: Text('Vui lòng nhập tên người dùng'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tên không để trống';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: !_isLoadPass,
            decoration: InputDecoration(
              label: Text('Mật khẩu'),
              hint: Text('Vui lòng nhập mật khẩu'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isLoadPass = !_isLoadPass;
                  });
                },
                icon: Icon(
                  _isLoadPass ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mật khẩu không trống';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Đăng nhập thành công')));
              }
            },
            label: Text(
              'Đăng nhập',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}
