import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/destination.dart';

/// Sumber data destinasi.
///
/// Saat ini data dibaca dari file JSON lokal (`assets/data/destinations.json`).
/// Pada tahap pengembangan berikutnya, isi `fetchDestinations` dapat diganti
/// dengan permintaan HTTP ke server, misalnya:
///
/// ```dart
/// final response = await http.get(Uri.parse('https://api.example.com/destinations'));
/// final decoded = json.decode(response.body) as Map<String, dynamic>;
/// ```
///
/// Bentuk JSON (`{"destinations": [...]}`) dipertahankan sama sehingga model
/// `Destination` dan seluruh tampilan tidak perlu diubah.
class DestinationRepository {
  Future<List<Destination>> fetchDestinations() async {
    final raw = await rootBundle.loadString('assets/data/destinations.json');
    final decoded = json.decode(raw) as Map<String, dynamic>;
    final items = decoded['destinations'] as List<dynamic>;
    return items
        .map((item) => Destination.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
