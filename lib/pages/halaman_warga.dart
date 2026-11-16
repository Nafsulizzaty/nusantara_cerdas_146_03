// lib/pages/halaman_warga.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Bagian 1: Layanan Favorit Warga (Consumer<FavoritModel>)
        Text(
          'Layanan Favorit Saya',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Consumer<FavoritModel>(
          builder: (context, favoritModel, child) {
            final daftar = favoritModel.daftarFavorit;
            if (daftar.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Belum ada layanan yang ditandai sebagai favorit.'),
                ),
              );
            }
            return Card(
              child: Column(
                children: daftar.map((namaLayanan) {
                  return ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(namaLayanan),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => favoritModel.batalTandai(namaLayanan),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        // Bagian 2: Keranjang Pengajuan Layanan
        Text(
          'Keranjang Pengajuan Layanan',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Consumer<PengajuanModel>(
          builder: (context, pengajuanModel, child) {
            final antrean = pengajuanModel.daftarPengajuan;
            if (antrean.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Keranjang pengajuan masih kosong. Pilih layanan untuk diajukan.'),
                ),
              );
            }
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...List.generate(antrean.length, (index) {
                      return ListTile(
                        leading: const Icon(Icons.assignment_turned_in_outlined),
                        title: Text(antrean[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => pengajuanModel.hapusPengajuan(index),
                        ),
                      );
                    }),
                    const Divider(),
                    FilledButton.icon(
                      onPressed: () {
                        pengajuanModel.kirimSemuaPengajuan();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Seluruh permohonan berhasil dikirim ke dinas terkait!'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text('Kirim Semua Pengajuan (${antrean.length})'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}