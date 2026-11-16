// lib/pages/halaman_layanan.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  static const Map<String, List>_dataLayanan = {
    'Perizinan': [
      {
        'nama': 'Izin Usaha Mikro (IUMK)',
        'deskripsi': 'Penerbitan legalitas usaha mikro secara daring bagi warga.'
      },
      {
        'nama': 'Izin Mendirikan Bangunan (PBG)',
        'deskripsi': 'Persetujuan bangunan gedung hunian dan komersial.'
      },
    ],
    'Kesehatan': [
      {
        'nama': 'Antrean Puskesmas Online',
        'deskripsi': 'Pendaftaran nomor antrean poli umum dan gigi tanpa menunggu lama.'
      },
      {
        'nama': 'Surat Keterangan Sehat',
        'deskripsi': 'Pengajuan surat keterangan sehat untuk keperluan kerja atau pendidikan.'
      },
    ],
    'Transportasi': [
      {
        'nama': 'Kartu Pelajar Bus Kota',
        'deskripsi': 'Pendaftaran tarif khusus transportasi publik terintegrasi.'
      },
      {
        'nama': 'Uji Kir Kendaraan Niaga',
        'deskripsi': 'Penjadwalan pemeriksaan kelaikan jalan kendaraan angkutan.'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: _dataLayanan.entries.map((entry) {
                final bidang = entry.key;
                final daftar = entry.value;

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: daftar.length,
                  separatorBuilder: (context, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final layanan = daftar[index];
                    final nama = layanan['nama']!;
                    // Memantau status favorit secara reaktif
                    final isFav = context.watch<FavoritModel>().apakahFavorit(nama);

                    return Card(
                      child: ListTile(
                        title: Text(nama),
                        subtitle: Text(layanan['deskripsi']!),
                        trailing: IconButton(
                          tooltip: isFav ? 'Hapus Favorit' : 'Tandai Favorit',
                          icon: Icon(
                            isFav ? Icons.star : Icons.star_border,
                            color: isFav ? Colors.amber : null,
                          ),
                          onPressed: () {
                            // Aksi sekali jalan tanpa mendengarkan perubahan
                            context.read<FavoritModel>().ubahStatus(nama);
                          },
                        ),
                        onTap: () async {
                          final hasil = await Navigator.pushNamed(
                            context,
                            '/detail-layanan',
                            arguments: {
                              'nama': nama,
                              'bidang': bidang,
                              'deskripsi': layanan['deskripsi']!,
                            },
                          );

                          if (hasil != null && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(hasil.toString())),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}