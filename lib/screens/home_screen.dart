import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import '../widgets/destination_card.dart';

/// Halaman 1: Beranda (sapaan, pencarian, kategori, destinasi populer & terbaru).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenList});

  /// Dipanggil untuk berpindah ke tab "Destinasi" setelah memilih kategori/mencari.
  final VoidCallback onOpenList;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.error!),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: state.load, child: const Text('Coba lagi')),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _Header(
          onSearch: (value) {
            state.setCategory('Semua');
            state.setQuery(value);
            onOpenList();
          },
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final category in state.categories)
                _CategoryTile(
                  category: category,
                  onTap: () {
                    state.setQuery('');
                    state.setCategory(category);
                    onOpenList();
                  },
                ),
            ],
          ),
        ),
        const _SectionTitle('Destinasi Populer'),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: state.popular.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) =>
                _PopularCard(destination: state.popular[i]),
          ),
        ),
        const _SectionTitle('Destinasi Terbaru'),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              for (final destination in state.latest)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DestinationCard(destination: destination),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onSearch});

  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 16,
        16,
        24,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.dark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Mau liburan ke mana hari ini?',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                backgroundColor: AppTheme.accent,
                child: Icon(Icons.flight_takeoff, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: onSearch,
            decoration: InputDecoration(
              hintText: 'Cari destinasi atau lokasi...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, required this.onTap});

  final String category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(categoryIcon(category), color: AppTheme.dark),
            ),
            const SizedBox(height: 6),
            Text(category, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _PopularCard extends StatelessWidget {
  const _PopularCard({required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width * 0.6).clamp(180.0, 280.0);

    return GestureDetector(
      onTap: () => openDetail(context, destination),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [destination.color, destination.color.withOpacity(0.5)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  destination.emoji,
                  style: const TextStyle(fontSize: 56),
                ),
              ),
            ),
            Text(
              destination.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.white),
                const SizedBox(width: 4),
                Text(destination.rating.toStringAsFixed(1)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    destination.category,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
