import 'package:flutter/material.dart';
import '../data/coffee_data.dart';
import '../theme.dart';
import '../widgets/coffee_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top + 16, 20, 22),
            decoration: const BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: const Text('Menu Favorit',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800)),
          ),
          Expanded(
            child: ValueListenableBuilder<Set<int>>(
              valueListenable: favorites,
              builder: (_, favs, __) {
                final list =
                    allCoffees.where((c) => favs.contains(c.id)).toList();
                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite_border_rounded,
                            size: 64, color: AppColors.grey.withOpacity(0.6)),
                        const SizedBox(height: 12),
                        const Text('Belum ada menu favorit',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark)),
                        const SizedBox(height: 4),
                        const Text('Tekan ikon hati pada menu untuk menyimpan',
                            style:
                                TextStyle(fontSize: 12, color: AppColors.grey)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  itemCount: list.length,
                  itemBuilder: (_, i) => CoffeeTile(coffee: list[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
