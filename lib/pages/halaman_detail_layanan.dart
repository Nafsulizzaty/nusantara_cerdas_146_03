// lib/pages/halaman_detail_layanan.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';

class HalamanDetailLayanan extends StatefulWidget {
  const HalamanDetailLayanan({super.key});

  @override
  State<HalamanDetailLayanan> createState() => _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  bool _sedangMengirim = false;

  Future<void> _prosesAjukan(String namaLayanan) async {
    if (_sedangMengirim) return;

    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi jeda pengiriman permohonan ke server dinas
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Tambahkan ke state aplikasi (Provider)
    context.read<PengajuanModel>().tambahPengajuan(namaLayanan);

    setState(() {
      _sedangMengirim = false;
    });

    // Kembalikan nilai balik ke halaman sebelumnya sesuai ketentuan Modul II & III
    Navigator.pop(context, 'Permohonan "$namaLayanan" berhasil ditambahkan!');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final namaLayanan = args?['nama'] ?? 'Layanan Publik';
    final bidang = args?['bidang'] ?? 'Umum';
    final deskripsi = args?['deskripsi'] ?? 'Informasi rincian layanan warga kota.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Layanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chip(
              label: Text('Bidang: $bidang'),
              avatar: const Icon(Icons.category, size: 18),
            ),
            const SizedBox(height: 12),
            Text(
              namaLayanan,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              deskripsi,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _sedangMengirim ? null : () => _prosesAjukan(namaLayanan),
              icon: _sedangMengirim
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(
                _sedangMengirim ? 'Sedang Mengirim...' : 'Ajukan Permohonan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}