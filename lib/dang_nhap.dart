import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String LOGIN_URL = 'https://dummyjson.com/auth/login';

class ThongTinNguoiDung {
  final int id;
  final String tenNguoiDung;
  final String hoTen;
  final String email;
  final String urlAnh;
  final String accessToken;

  ThongTinNguoiDung({
    required this.id,
    required this.tenNguoiDung,
    required this.hoTen,
    required this.email,
    required this.urlAnh,
    required this.accessToken,
  });

  factory ThongTinNguoiDung.tuJson(Map<String, dynamic> json, String token) {
    return ThongTinNguoiDung(
      id: json['id'] as int,
      tenNguoiDung: json['username'] as String,
      hoTen: '${json['firstName']} ${json['lastName']}',
      email: json['email'] as String,
      urlAnh: json['image'] as String,
      accessToken: token,
    );
  }
}

class DangNhap extends StatelessWidget {
  const DangNhap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng Nhập')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: FormDangNhap(),
        ),
      ),
    );
  }
}

class FormDangNhap extends StatefulWidget {
  const FormDangNhap({super.key});

  @override
  State<FormDangNhap> createState() => _TrangThaiFormDangNhap();
}

class _TrangThaiFormDangNhap extends State<FormDangNhap> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tenNguoiDungController = TextEditingController();
  final TextEditingController _matKhauController = TextEditingController();

  bool _isHienMatKhau = false;
  bool _isLoading = false;
  String _thongBaoLoi = '';

  @override
  void initState() {
    super.initState();
    _tenNguoiDungController.text = 'emilys';
    _matKhauController.text = 'emilyspass';
  }

  @override
  void dispose() {
    _tenNguoiDungController.dispose();
    _matKhauController.dispose();
    super.dispose();
  }

  Future<void> _xuLyDangNhap() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _thongBaoLoi = '';
    });

    final tenNguoiDung = _tenNguoiDungController.text;
    final matKhau = _matKhauController.text;

    try {
      final response = await http.post(
        Uri.parse(LOGIN_URL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': tenNguoiDung, 'password': matKhau}),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> duLieu = jsonDecode(response.body);

        // Tìm token với nhiều tên khóa có thể
        final String? accessToken = duLieu['accessToken'] ?? duLieu['token'];

        if (accessToken != null && accessToken.isNotEmpty) {
          final ThongTinNguoiDung nguoiDung = ThongTinNguoiDung.tuJson(
            duLieu,
            accessToken,
          );

          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ManHinhHoSo(nguoiDung: nguoiDung),
            ),
          );
        } else {
          print('Các keys trong response: ${duLieu.keys.toList()}');
          setState(() {
            _thongBaoLoi = 'Không tìm thấy token trong phản hồi';
          });
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          setState(() {
            _thongBaoLoi = errorData['message'] ?? 'Đăng nhập thất bại';
          });
        } catch (e) {
          setState(() {
            _thongBaoLoi = 'Đăng nhập thất bại (${response.statusCode})';
          });
        }
      }
    } catch (e) {
      setState(() {
        _thongBaoLoi = 'Lỗi kết nối: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Đăng Nhập',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),

          TextFormField(
            controller: _tenNguoiDungController,
            decoration: const InputDecoration(
              labelText: 'Tên người dùng',
              hintText: 'Nhập tên người dùng',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên người dùng';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: _matKhauController,
            obscureText: !_isHienMatKhau,
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              hintText: 'Nhập mật khẩu',
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isHienMatKhau = !_isHienMatKhau;
                  });
                },
                icon: Icon(
                  _isHienMatKhau ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              return null;
            },
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: _isLoading ? null : _xuLyDangNhap,
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('ĐĂNG NHẬP'),
          ),

          const SizedBox(height: 20),

          if (_thongBaoLoi.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red[100],
              child: Text(
                _thongBaoLoi,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}

class ManHinhHoSo extends StatelessWidget {
  final ThongTinNguoiDung nguoiDung;

  const ManHinhHoSo({super.key, required this.nguoiDung});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ Sơ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const DangNhap()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Hiển thị ảnh đơn giản
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(nguoiDung.urlAnh),
              onBackgroundImageError: (exception, stackTrace) =>
                  const Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),

            Text(
              nguoiDung.hoTen,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '@${nguoiDung.tenNguoiDung}',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // Thông tin
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(nguoiDung.email),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('ID'),
                      subtitle: Text(nguoiDung.id.toString()),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.vpn_key),
                      title: const Text('Token'),
                      subtitle: Text(
                        nguoiDung.accessToken.length > 30
                            ? '${nguoiDung.accessToken.substring(0, 30)}...'
                            : nguoiDung.accessToken,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Nút đăng xuất
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const DangNhap()),
                );
              },
              child: const Text('Đăng Xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
