import 'package:flutter/material.dart';

/// Model data destinasi wisata.
///
/// Struktur field sengaja dibuat mirip respons JSON API pada umumnya,
/// sehingga saat tahap integrasi API cukup mengganti sumber data
/// (lihat `DestinationRepository`) tanpa mengubah model maupun UI.
class Destination {
  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.bestTime,
    required this.suitableFor,
    required this.emoji,
    required this.colorHex,
    required this.description,
    required this.rating,
    required this.publishedAt,
    required this.highlights,
    required this.tips,
  });

  final int id;
  final String name;
  final String location;
  final String category;
  final String bestTime;
  final String suitableFor;
  final String emoji;
  final String colorHex;
  final String description;
  final double rating;
  final DateTime publishedAt;
  final List<String> highlights;
  final List<String> tips;

  /// Warna aksen destinasi, dikonversi dari string hex (contoh: "#4DD0E1").
  Color get color => Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as int,
      name: json['name'] as String,
      location: json['location'] as String,
      category: json['category'] as String,
      bestTime: json['bestTime'] as String,
      suitableFor: json['suitableFor'] as String,
      emoji: json['emoji'] as String,
      colorHex: json['color'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      highlights: List<String>.from(json['highlights'] as List),
      tips: List<String>.from(json['tips'] as List),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'category': category,
        'bestTime': bestTime,
        'suitableFor': suitableFor,
        'emoji': emoji,
        'color': colorHex,
        'description': description,
        'rating': rating,
        'publishedAt': publishedAt.toIso8601String(),
        'highlights': highlights,
        'tips': tips,
      };
}
