import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_food/main.dart';

void main() {
  testWidgets('Aplikasi dapat memuat tampilan utama dan bernavigasi', (WidgetTester tester) async {
    // Build aplikasi SaveFoodApp
    await tester.pumpWidget(const SaveFoodApp());

    // Verifikasi ikon Beranda muncul
    expect(find.byIcon(Icons.home), findsOneWidget);

    // Ketuk tab Profil (indeks ke-2 pada navigasi)
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    // Verifikasi teks nama profil muncul
    expect(find.text('Victoria Lusiana Manullang'), findsOneWidget);
  });
}