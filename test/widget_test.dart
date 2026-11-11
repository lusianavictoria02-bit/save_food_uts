import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_food/main.dart'; // Sesuaikan jika nama package milikmu berbeda

void main() {
  testWidgets('Navigasi bawah menampilkan 3 tujuan', (tester) async {
    await tester.pumpWidget(const SaveFoodApp());

    // Memastikan ada 3 pilihan navigasi (Beranda, Keranjang, Profil)
    expect(find.byType(NavigationDestination), findsNWidgets(3));
  });

  testWidgets('Pindah ke tab Profil menampilkan tombol Keluar', (tester) async {
    await tester.pumpWidget(const SaveFoodApp());

    // 1. Cari tab dengan label "Profil" di NavigationBar lalu tap
    final profilTab = find.text('Profil');
    expect(profilTab, findsOneWidget);
    await tester.tap(profilTab);

    // 2. Tunggu animasi perpindahan halaman selesai
    await tester.pumpAndSettle();

    // 3. Pastikan teks "Keluar" atau "Victoria" ditemukan di halaman Profil
    expect(find.textContaining('Keluar'), findsOneWidget);
  });
}