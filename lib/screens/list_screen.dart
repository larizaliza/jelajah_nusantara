import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/destination_card.dart';

/// Halaman 2: Daftar destinasi dengan pencarian dan filter kategori.
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    // Sinkronkan kolom pencarian bila query diubah dari halaman Beranda.
    if (_controller.text != state.query) {
      _controller.value = TextEditingValue(
        text: state.query,
        selection: TextSelection.collapsed(offset: state.query.length),
      );
    }

    final categories = ['Semua', ...state.categories];
    final destinations = state.filtered;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Destinasi')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _controller,
              onChanged: state.setQuery,
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
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final category = categories[i];
                return ChoiceChip(
                  label: Text(category),
                  selected: state.selectedCategory == category,
                  selectedColor: AppTheme.accent,
                  onSelected: (_) => state.setCategory(category),
                );
              },
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : destinations.isEmpty
                    ? const Center(child: Text('Destinasi tidak ditemukan.'))
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          // Responsif: grid dua kolom pada layar lebar.
                          if (constraints.maxWidth >= 600) {
                            return GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                mainAxisExtent: 104,
                              ),
                              itemCount: destinations.length,
                              itemBuilder: (_, i) =>
                                  DestinationCard(destination: destinations[i]),
                            );
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: destinations.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (_, i) =>
                                DestinationCard(destination: destinations[i]),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
