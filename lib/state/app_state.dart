import 'package:flutter/material.dart';

import '../data/destination_repository.dart';
import '../models/destination.dart';

/// State aplikasi: daftar destinasi, filter pencarian/kategori, dan favorit.
class AppState extends ChangeNotifier {
  AppState(this._repository);

  final DestinationRepository _repository;

  List<Destination> _destinations = [];
  final Set<int> _favoriteIds = {};

  bool isLoading = true;
  String? error;
  String selectedCategory = 'Semua';
  String query = '';

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      _destinations = await _repository.fetchDestinations();
    } catch (e) {
      error = 'Gagal memuat data destinasi.';
    }
    isLoading = false;
    notifyListeners();
  }

  List<Destination> get destinations => List.unmodifiable(_destinations);

  List<String> get categories =>
      _destinations.map((d) => d.category).toSet().toList();

  /// Destinasi dengan rating tertinggi.
  List<Destination> get popular {
    final sorted = [..._destinations]
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(5).toList();
  }

  /// Destinasi yang paling baru ditambahkan.
  List<Destination> get latest {
    final sorted = [..._destinations]
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return sorted.take(5).toList();
  }

  /// Destinasi setelah difilter berdasarkan kategori dan kata kunci
  /// (nama atau lokasi).
  List<Destination> get filtered {
    final q = query.trim().toLowerCase();
    return _destinations.where((d) {
      final matchCategory =
          selectedCategory == 'Semua' || d.category == selectedCategory;
      final matchQuery = q.isEmpty ||
          d.name.toLowerCase().contains(q) ||
          d.location.toLowerCase().contains(q);
      return matchCategory && matchQuery;
    }).toList();
  }

  List<Destination> get favorites =>
      _destinations.where((d) => _favoriteIds.contains(d.id)).toList();

  bool isFavorite(int id) => _favoriteIds.contains(id);

  void toggleFavorite(int id) {
    if (!_favoriteIds.remove(id)) {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setQuery(String value) {
    query = value;
    notifyListeners();
  }
}

/// Menyediakan [AppState] ke seluruh widget di bawahnya.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;
  }
}
