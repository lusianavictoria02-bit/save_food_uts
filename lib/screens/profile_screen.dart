import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Data profil dipusatkan di satu tempat (masih statis, bukan lagi teks
  // "Nama Pengguna"). Nanti bisa diganti dari Login/Register.
  static const _nama = 'Victoria Lusiana Manullang';
  static const _email = 'pengguna@email.com';
  static const _jumlahDiselamatkan = 12;
  static const _totalHemat = 'Rp180.000';

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Segera hadir')));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final menus = [
      (Icons.receipt_long, 'Riwayat Pesanan'),
      (Icons.location_on_outlined, 'Alamat Saya'),
      (Icons.notifications_outlined, 'Notifikasi'),
      (Icons.help_outline, 'Bantuan'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Column(children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: cs.primaryContainer,
                child: Icon(Icons.person, size: 48, color: cs.onPrimaryContainer),
              ),
              const SizedBox(height: 12),
              Text(_nama,
                  style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const Text(_email),
              const SizedBox(height: 12),
              // RichText: satu kalimat dengan beberapa gaya teks (materi UI Components)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  children: [
                    const TextSpan(text: 'Kamu sudah menyelamatkan '),
                    TextSpan(
                      text: '$_jumlahDiselamatkan makanan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: cs.primary),
                    ),
                    const TextSpan(text: ' dan menghemat '),
                    TextSpan(
                      text: _totalHemat,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: cs.primary),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 20),
            const Row(children: [
              Expanded(
                  child: StatTile(
                      icon: Icons.restaurant,
                      value: '$_jumlahDiselamatkan',
                      label: 'Makanan diselamatkan')),
              SizedBox(width: 12),
              Expanded(
                  child: StatTile(
                      icon: Icons.savings,
                      value: _totalHemat,
                      label: 'Total hemat')),
            ]),
            const SizedBox(height: 20),
            // Align: menempatkan judul bagian di sisi kiri (materi Layout Dasar)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Menu',
                  style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  for (final m in menus)
                    ListTile(
                      leading: Icon(m.$1),
                      title: Text(m.$2),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _soon(context),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _soon(context),
              icon: const Icon(Icons.logout),
              label: const Text('Keluar'),
            ),
          ]),
        ),
      ),
    );
  }
}