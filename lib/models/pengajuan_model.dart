// lib/models/pengajuan_model.dart
import 'package:flutter/foundation.dart';

class PengajuanModel extends ChangeNotifier {
  final List<String> _daftarPengajuan = [];

  List<String> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);

  int get totalPengajuan => _daftarPengajuan.length;

  void tambahPengajuan(String namaLayanan) {
    _daftarPengajuan.add(namaLayanan);
    notifyListeners();
  }

  void hapusPengajuan(int index) {
    if (index >= 0 && index < _daftarPengajuan.length) {
      _daftarPengajuan.removeAt(index);
      notifyListeners();
    }
  }

  void kirimSemuaPengajuan() {
    if (_daftarPengajuan.isEmpty) return;
    _daftarPengajuan.clear();
    notifyListeners();
  }
}