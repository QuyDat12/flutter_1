import 'package:flutter/material.dart';
import 'dart:async'; // Cần thiết cho Timer
import 'package:fluttertoast/fluttertoast.dart'; // Thư viện cho Toast

class BoDemThoiGian extends StatefulWidget {
  const BoDemThoiGian({super.key});

  @override
  State<BoDemThoiGian> createState() => _BoDemThoiGianState();
}

class _BoDemThoiGianState extends State<BoDemThoiGian> {
  // --- 1. KHAI BÁO BIẾN TRẠNG THÁI VÀ ĐIỀU KHIỂN (VIỆT HÓA) ---
  final TextEditingController _boDieuKhienNhapLieu = TextEditingController();
  int _tongSoGiayConLai = 0; // Số giây hiện tại còn lại
  int _soGiayBanDau = 0; // Số giây đã nhập ban đầu
  Timer? _dongHoBamGio; // Đối tượng Timer
  bool _dangChay = false; // Trạng thái: Đang chạy (true) hay Đã dừng (false)

  // Đối tượng hiển thị Toast
  late FToast _hienThiToast;

  @override
  void initState() {
    super.initState();
    _hienThiToast = FToast();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hienThiToast.init(context);
    });
  }

  // --- 2. HÀM ĐỊNH DẠNG THỜI GIAN (Phút:Giây) ---
  String _dinhDangThoiGian(int giay) {
    if (giay < 0) return '00:00';
    final int phut = (giay ~/ 60);
    final int giayConLai = (giay % 60);

    final String chuoiPhut = phut.toString().padLeft(2, '0');
    final String chuoiGiay = giayConLai.toString().padLeft(2, '0');

    return '$chuoiPhut:$chuoiGiay';
  }

  // --- 3. HÀM BẮT ĐẦU ĐẾM NGƯỢC ---
  void _batDauDemNguoc() {
    if (_dangChay) return;

    final int? soGiayNhapVao = int.tryParse(_boDieuKhienNhapLieu.text.trim());

    if (soGiayNhapVao == null || soGiayNhapVao <= 0) {
      _hienThiThongBaoToast("Vui lòng nhập số giây hợp lệ (> 0).", Colors.red);
      return;
    }

    setState(() {
      _soGiayBanDau = soGiayNhapVao;
      _tongSoGiayConLai = soGiayNhapVao;
      _dangChay = true;
    });

    _dongHoBamGio = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_tongSoGiayConLai > 0) {
          _tongSoGiayConLai--;
        } else {
          // Dừng timer khi về 0
          _dongHoBamGio?.cancel();
          _dangChay = false;
          _hienThiThongBaoToast("HẾT GIỜ!", Colors.orange);
        }
      });
    });
  }

  // --- 4. HÀM ĐẶT LẠI ---
  void _datLaiBoDem() {
    _dongHoBamGio?.cancel();
    setState(() {
      _tongSoGiayConLai = 0;
      _soGiayBanDau = 0;
      _dangChay = false;
      _boDieuKhienNhapLieu.clear();
    });
  }

  // --- 5. HÀM HIỂN THỊ TOAST ---
  void _hienThiThongBaoToast(String thongBao, Color mauNen) {
    if (mounted) {
      _hienThiToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: mauNen,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.alarm, color: Colors.white),
              const SizedBox(width: 12.0),
              Text(
                thongBao,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void dispose() {
    _dongHoBamGio?.cancel();
    _boDieuKhienNhapLieu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String thoiGianHienThi = _dinhDangThoiGian(_tongSoGiayConLai);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bộ đếm thời gian',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Nhập số giây cần đếm',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Center(
                child: TextField(
                  controller: _boDieuKhienNhapLieu,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  enabled: !_dangChay,
                  decoration: InputDecoration(
                    hintText: 'Nhập số giây',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                thoiGianHienThi,
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.w100),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    // Cho phép nhấn nếu KHÔNG đang chạy
                    onPressed: _dangChay ? null : _batDauDemNguoc,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Bắt đầu'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  ElevatedButton.icon(
                    onPressed: _datLaiBoDem,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Đặt lại'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
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
