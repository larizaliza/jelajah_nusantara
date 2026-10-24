import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';

/// Halaman 3: Detail destinasi (info, daya tarik, tips, dan tombol favorit).
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final isFav = state.isFavorite(destination.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            backgroundColor: AppTheme.dark,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                tooltip: isFav ? 'Hapus dari favorit' : 'Tambah ke favorit',
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                color: isFav ? Colors.redAccent : Colors.white,
                onPressed: () => state.toggleFavorite(destination.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(destination.name),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [destination.color, AppTheme.dark],
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  destination.emoji,
                  style: const TextStyle(fontSize: 96),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                 child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _InfoChip(
                            icon: Icons.place_outlined,
                            label: destination.location,
                          ),
                          _InfoChip(
                            icon: categoryIcon(destination.category),
                            label: destination.category,
                          ),
                          _InfoChip(
                            icon: Icons.star,
                            label: destination.rating.toStringAsFixed(1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              _InfoRow(
                                icon: Icons.calendar_month,
                                title: 'Waktu terbaik',
                                value: destination.bestTime,
                              ),
                              const Divider(height: 20),
                              _InfoRow(
                                icon: Icons.groups_2_outlined,
                                title: 'Cocok untuk',
                                value: destination.suitableFor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ditambahkan ${formatDate(destination.publishedAt)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        destination.description,
                        style: const TextStyle(height: 1.5),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Daya tarik',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              for (final item in destination.highlights)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 18,
                                        color: AppTheme.accent,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(child: Text(item)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Tips berkunjung',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (var i = 0; i < destination.tips.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: AppTheme.dark,
                                child: Text(
                                  '${i + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  destination.tips[i],
                                  style: const TextStyle(height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.accent),
          const SizedBox(width: 4),
          Flexible(child: Text(label, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.accent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}
