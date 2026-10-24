import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../widgets/destination_card.dart';

/// Halaman 4: Daftar destinasi favorit pengguna.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = AppScope.of(context).favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Destinasi Favorit')),
      body: favorites.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 56, color: Colors.black38),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada destinasi favorit.\nTekan ikon hati pada halaman detail.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) => DestinationCard(destination: favorites[i]),
            ),
    );
  }
}
