import 'package:flutter/material.dart';
import '../data/coffee_data.dart';
import '../models/coffee.dart';
import '../theme.dart';

/// Halaman detail menu (dibuka lewat Navigator.push).
class DetailPage extends StatefulWidget {
  final Coffee coffee;
  const DetailPage({super.key, required this.coffee});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _sizeIndex = 1;
  int _qty = 1;
  static const _sizes = ['S', 'M', 'L'];
  static const _extra = [0, 4000, 8000];

  int get _total => (widget.coffee.price + _extra[_sizeIndex]) * _qty;

  @override
  Widget build(BuildContext context) {
    final c = widget.coffee;
    final top = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Header =====
                  Container(
                    width: double.infinity,
                    height: 280 + top,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [c.color, c.colorDark],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: top),
                            child: Icon(c.icon,
                                size: 130,
                                color: Colors.white.withOpacity(0.95)),
                          ),
                        ),
                        Positioned(
                          top: top + 8,
                          left: 16,
                          child: _circleButton(
                            Icons.arrow_back_rounded,
                            () => Navigator.pop(context),
                          ),
                        ),
                        Positioned(
                          top: top + 8,
                          right: 16,
                          child: ValueListenableBuilder<Set<int>>(
                            valueListenable: favorites,
                            builder: (_, favs, __) {
                              final fav = favs.contains(c.id);
                              return _circleButton(
                                fav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                () => toggleFavorite(c.id),
                                color: fav ? Colors.redAccent : Colors.white,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(c.name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.dark)),
                            ),
                            const Icon(Icons.star_rounded,
                                color: Colors.amber, size: 22),
                            const SizedBox(width: 4),
                            Text(c.rating.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(c.category,
                            style: const TextStyle(color: AppColors.grey)),
                        const SizedBox(height: 16),

                        // Info singkat
                        Row(
                          children: [
                            _infoBox(Icons.local_fire_department_rounded,
                                '${c.calories} kkal'),
                            const SizedBox(width: 10),
                            _infoBox(Icons.sell_rounded, c.priceText),
                            const SizedBox(width: 10),
                            _infoBox(Icons.schedule_rounded, '5 mnt'),
                          ],
                        ),
                        const SizedBox(height: 22),

                        const Text('Deskripsi',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        Text(c.description,
                            style: const TextStyle(
                                height: 1.5, color: Color(0xFF5C4B40))),
                        const SizedBox(height: 22),

                        const Text('Bahan',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: c.ingredients
                              .map((e) => Chip(
                                    label: Text(e),
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                        color: AppColors.brown.withOpacity(0.2)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: AppColors.brown),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 22),

                        const Text('Ukuran',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(_sizes.length, (i) {
                            final active = i == _sizeIndex;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _sizeIndex = i),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: EdgeInsets.only(
                                      right: i == _sizes.length - 1 ? 0 : 10),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        active ? AppColors.brown : Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: AppColors.brown
                                            .withOpacity(active ? 1 : 0.2)),
                                  ),
                                  child: Text(
                                    _sizes[i],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: active
                                          ? Colors.white
                                          : AppColors.brown,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== Bar bawah: jumlah + tombol =====
          Container(
            padding: EdgeInsets.fromLTRB(
                20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.12),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                _qtyButton(Icons.remove_rounded,
                    () => setState(() => _qty = _qty > 1 ? _qty - 1 : 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text('$_qty',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800)),
                ),
                _qtyButton(Icons.add_rounded, () => setState(() => _qty++)),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brown,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.dark,
                          content: Text(
                              '$_qty x ${c.name} (${_sizes[_sizeIndex]}) ditambahkan'),
                        ),
                      );
                    },
                    child: Text('Tambah  •  ${formatRupiah(_total)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap,
      {Color color = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  Widget _infoBox(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.accent, size: 22),
            const SizedBox(height: 4),
            Text(text,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.brown.withOpacity(0.2)),
        ),
        child: Icon(icon, color: AppColors.brown, size: 20),
      ),
    );
  }
}
