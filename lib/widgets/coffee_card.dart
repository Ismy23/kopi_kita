import 'package:flutter/material.dart';
import '../data/coffee_data.dart';
import '../models/coffee.dart';
import '../pages/detail_page.dart';
import '../theme.dart';

void openDetail(BuildContext context, Coffee coffee) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => DetailPage(coffee: coffee)),
  );
}

/// Kotak ikon bergradasi pengganti gambar produk.
class CoffeeThumb extends StatelessWidget {
  final Coffee coffee;
  final double size;
  const CoffeeThumb({super.key, required this.coffee, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [coffee.color, coffee.colorDark],
        ),
      ),
      child: Icon(coffee.icon, color: Colors.white, size: size * 0.5),
    );
  }
}

/// Kartu horizontal untuk bagian "Menu Populer".
class PopularCard extends StatelessWidget {
  final Coffee coffee;
  final double width;
  const PopularCard({super.key, required this.coffee, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openDetail(context, coffee),
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 14, bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [coffee.color, coffee.colorDark],
          ),
          boxShadow: [
            BoxShadow(
              color: coffee.color.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                  const SizedBox(width: 3),
                  Text(
                    coffee.rating.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: Icon(coffee.icon,
                  size: 54, color: Colors.white.withOpacity(0.95)),
            ),
            const Spacer(),
            Text(
              coffee.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              coffee.priceText,
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

/// Item list vertikal (dipakai di Beranda, Menu, dan Favorit).
class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  const CoffeeTile({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openDetail(context, coffee),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CoffeeThumb(coffee: coffee, size: 68),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffee.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.dark),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    coffee.category,
                    style: const TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Colors.amber, size: 16),
                      const SizedBox(width: 3),
                      Text(coffee.rating.toString(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                      if (coffee.isNew) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('BARU',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accent)),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ValueListenableBuilder<Set<int>>(
                  valueListenable: favorites,
                  builder: (_, favs, __) {
                    final fav = favs.contains(coffee.id);
                    return GestureDetector(
                      onTap: () => toggleFavorite(coffee.id),
                      child: Icon(
                        fav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: fav ? Colors.redAccent : AppColors.grey,
                        size: 22,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),
                Text(
                  coffee.priceText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.brown),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
