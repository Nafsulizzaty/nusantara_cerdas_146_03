// lib/pages/halaman_beranda.dart
import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang di Nusantara Cerdas',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Portal layanan publik terpadu. Tandai layanan favorit Anda dan ajukan beberapa permohonan sekaligus dalam satu kunjungan.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}