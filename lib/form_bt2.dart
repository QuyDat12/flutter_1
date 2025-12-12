import 'package:flutter/material.dart';

class FormBt2 extends StatelessWidget {
  const FormBt2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form đăng ký tài khoản'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(child: FormDangKyTaiKhoan()),
    );
  }
}

class FormDangKyTaiKhoan extends StatefulWidget {
  const FormDangKyTaiKhoan({super.key});

  @override
  State<FormDangKyTaiKhoan> createState() => _FormDangKyTaiKhoanState();
}

class _FormDangKyTaiKhoanState extends State<FormDangKyTaiKhoan> {
  final _formKey = GlobalKey<FormState>();

  bool _hienMatKhau = false;

  final TextEditingController _matKhauController = TextEditingController();

  @override
  void dispose() {
    _matKhauController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              label: Text(' Vui lòng nhập tên người dùng'),
              hint: Text('Tên người dùng'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Không để trống';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              label: Text(' Vui lòng nhập tên email'),
              hint: Text('Email'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Không để trống';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Email không hợp lệ';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _matKhauController,
            obscureText: !_hienMatKhau,
            decoration: InputDecoration(
              label: Text('Vui lòng nhập mật khẩu'),
              hint: Text('Mật khẩu'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hienMatKhau = !_hienMatKhau;
                  });
                },
                icon: _hienMatKhau
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: _hienMatKhau,
            decoration: InputDecoration(
              label: Text('Vui lòng xác nhận mật khẩu'),
              hint: Text('Xác nhận mật khẩu'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hienMatKhau = !_hienMatKhau;
                  });
                },
                icon: _hienMatKhau
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Không để trống';
              }
              if (value != _matKhauController.text) {
                return 'Mật khẩu không khớp';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đăng ký thành công')),
                );
              }
            },
            label: Text('Đăng ký', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}
