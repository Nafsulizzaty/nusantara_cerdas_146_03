// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';
import 'pages/halaman_beranda.dart';
import 'pages/halaman_detail_layanan.dart';
import 'pages/halaman_layanan.dart';
import 'pages/halaman_warga.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritModel()),
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusantara Cerdas Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const KerangkaNavigasiAdaptif(),
        '/detail-layanan': (context) => const HalamanDetailLayanan(),
      },
    );
  }
}

class KerangkaNavigasiAdaptif extends StatefulWidget {
  const KerangkaNavigasiAdaptif({super.key});

  @override
  State<KerangkaNavigasiAdaptif> createState() => _KerangkaNavigasiAdaptifState();
}

class _KerangkaNavigasiAdaptifState extends State<KerangkaNavigasiAdaptif> {
  int _indeksTujuan = 0;

  static const List<Widget> _daftarHalaman = [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  // Widget ikon Warga dengan Badge yang hanya dibangun ulang saat totalPengajuan berubah
  Widget _ikonWargaDenganBadge({required bool terpilih}) {
    return Builder(
      builder: (context) {
        final total = context.select<PengajuanModel, int>(
          (model) => model.totalPengajuan,
        );
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(terpilih ? Icons.person : Icons.person_outline),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLayarLebar = constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Nusantara Cerdas Mobile'),
          ),
          drawer: NavigationDrawer(
            selectedIndex: _indeksTujuan,
            onDestinationSelected: (index) {
              setState(() => _indeksTujuan = index);
              Navigator.pop(context);
            },
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text(
                  'Menu Utama',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Beranda'),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view),
                label: Text('Layanan'),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Warga'),
              ),
            ],
          ),
          body: Row(
            children: [
              if (isLayarLebar)
                NavigationRail(
                  selectedIndex: _indeksTujuan,
                  onDestinationSelected: (index) {
                    setState(() => _indeksTujuan = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.grid_view_outlined),
                      selectedIcon: Icon(Icons.grid_view),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: _ikonWargaDenganBadge(terpilih: false),
                      selectedIcon: _ikonWargaDenganBadge(terpilih: true),
                      label: const Text('Warga'),
                    ),
                  ],
                ),
              if (isLayarLebar) const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: IndexedStack(
                  index: _indeksTujuan,
                  children: _daftarHalaman,
                ),
              ),
            ],
          ),
          bottomNavigationBar: isLayarLebar
              ? null
              : NavigationBar(
                  selectedIndex: _indeksTujuan,
                  onDestinationSelected: (index) {
                    setState(() => _indeksTujuan = index);
                  },
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.grid_view_outlined),
                      selectedIcon: Icon(Icons.grid_view),
                      label: 'Layanan',
                    ),
                    NavigationDestination(
                      icon: _ikonWargaDenganBadge(terpilih: false),
                      selectedIcon: _ikonWargaDenganBadge(terpilih: true),
                      label: 'Warga',
                    ),
                  ],
                ),
        );
      },
    );
  }
}