import 'package:flutter/material.dart';
import '../data/coffee_data.dart';
import '../theme.dart';
import '../widgets/coffee_card.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onOpenMenu;
  const HomePage({super.key, required this.onOpenMenu});

  void _openCategory(String cat) {
    selectedCategory.value = cat;
    onOpenMenu();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = (width * 0.45).clamp(150.0, 220.0);
    final popular = allCoffees.where((c) => c.isPopular).toList();
    final newest = allCoffees.where((c) => c.isNew).toList();

    final quick = <Map<String, dynamic>>[
      {'label': 'Kopi', 'icon': Icons.coffee_rounded, 'color': const Color(0xFF6F4E37)},
      {'label': 'Non-Kopi', 'icon': Icons.local_drink_rounded, 'color': const Color(0xFF7CA57A)},
      {'label': 'Makanan', 'icon': Icons.bakery_dining_rounded, 'color': const Color(0xFFE0A458)},
      {'label': 'Dessert', 'icon': Icons.cake_rounded, 'color': const Color(0xFFB5838D)},
    ];

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ===== Header =====
          Container(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top + 18, 20, 26),
            decoration: const BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Selamat Datang',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text('Mau ngopi apa hari ini?',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.65),
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: AppColors.accent, shape: BoxShape.circle),
                      child:
                          const Icon(Icons.coffee_rounded, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _openCategory('Semua'),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded,
                            color: Colors.white.withOpacity(0.7)),
                        const SizedBox(width: 10),
                        Text('Cari menu favoritmu...',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== Kategori =====
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: quick.map((q) {
                final Color col = q['color'] as Color;
                return GestureDetector(
                  onTap: () => _openCategory(q['label'] as String),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: col.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(q['icon'] as IconData, color: col, size: 28),
                      ),
                      const SizedBox(height: 6),
                      Text(q['label'] as String,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.dark)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // ===== Menu Populer =====
          _sectionTitle('Menu Populer', onTap: () => _openCategory('Semua')),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 6),
              itemCount: popular.length,
              itemBuilder: (_, i) =>
                  PopularCard(coffee: popular[i], width: cardWidth),
            ),
          ),

          // ===== Menu Terbaru =====
          _sectionTitle('Menu Terbaru'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: newest.map((c) => CoffeeTile(coffee: c)).toList(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark)),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: const Text('Lihat semua',
                  style: TextStyle(
                      color: AppColors.accent, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }
}
