import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';

/// Kartu destinasi yang dipakai di halaman Beranda, Daftar, dan Favorit.
class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final isFav = AppScope.of(context).isFavorite(destination.id);

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openDetail(context, destination),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: destination.color.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  destination.emoji,
                  style: const TextStyle(fontSize: 34),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      destination.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          size: 13,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            destination.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          destination.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          destination.category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        if (isFav) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.favorite,
                            size: 14,
                            color: Colors.red,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => openDetail(context, destination),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Lihat', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
