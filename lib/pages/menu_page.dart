import 'package:flutter/material.dart';
import '../data/coffee_data.dart';
import '../theme.dart';
import '../widgets/coffee_card.dart';

/// Halaman daftar menu dengan filter kategori dan pencarian.
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top + 16, 20, 20),
            decoration: const BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Daftar Menu',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 14),
                TextField(
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: AppColors.accent,
                  decoration: InputDecoration(
                    hintText: 'Cari menu...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: Colors.white.withOpacity(0.7)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.12),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Chip kategori
          SizedBox(
            height: 56,
            child: ValueListenableBuilder<String>(
              valueListenable: selectedCategory,
              builder: (_, selected, __) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: categories.length,
                  itemBuilder: (_, i) {
                    final cat = categories[i];
                    final active = cat == selected;
                    return GestureDetector(
                      onTap: () => selectedCategory.value = cat,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active ? AppColors.brown : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: active ? Colors.white : AppColors.brown,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Daftar
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: selectedCategory,
              builder: (_, selected, __) {
                final list = allCoffees.where((c) {
                  final okCat = selected == 'Semua' || c.category == selected;
                  final okQuery = c.name
                      .toLowerCase()
                      .contains(_query.trim().toLowerCase());
                  return okCat && okQuery;
                }).toList();

                if (list.isEmpty) {
                  return const Center(
                    child: Text('Menu tidak ditemukan',
                        style: TextStyle(color: AppColors.grey)),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
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
