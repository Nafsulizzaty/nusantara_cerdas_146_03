// lib/models/favorit_model.dart
import 'package:flutter/foundation.dart';

class FavoritModel extends ChangeNotifier {
  final Set<String> _daftarFavorit = {};

  List<String> get daftarFavorit => List.unmodifiable(_daftarFavorit);

  bool apakahFavorit(String namaLayanan) {
    return _daftarFavorit.contains(namaLayanan);
  }

  void tandai(String namaLayanan) {
    if (_daftarFavorit.add(namaLayanan)) {
      notifyListeners();
    }
  }

  void batalTandai(String namaLayanan) {
    if (_daftarFavorit.remove(namaLayanan)) {
      notifyListeners();
    }
  }

  void ubahStatus(String namaLayanan) {
    if (apakahFavorit(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}