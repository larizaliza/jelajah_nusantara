import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../screens/detail_screen.dart';

const List<String> _monthNames = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

/// Contoh: 2025-10-01 -> "01 Oktober 2025".
String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  return '$day ${_monthNames[date.month - 1]} ${date.year}';
}

/// Ikon untuk setiap kategori destinasi.
IconData categoryIcon(String category) {
  switch (category) {
    case 'Pantai':
      return Icons.beach_access;
    case 'Gunung':
      return Icons.terrain;
    case 'Budaya':
      return Icons.account_balance;
    case 'Alam':
      return Icons.park;
    default:
      return Icons.explore;
  }
}

/// Navigasi ke halaman detail destinasi.
void openDetail(BuildContext context, Destination destination) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => DetailScreen(destination: destination)),
  );
}
