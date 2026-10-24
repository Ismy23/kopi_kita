import 'package:flutter/material.dart';
import '../theme.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'menu_page.dart';

/// Kerangka utama dengan BottomNavigationBar (3 tab).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _goTo(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onOpenMenu: () => _goTo(1)),
      const MenuPage(),
      const FavoritePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: _goTo,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: AppColors.brown,
          unselectedItemColor: AppColors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(Icons.coffee_rounded), label: 'Menu'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: 'Favorit'),
          ],
        ),
      ),
    );
  }
}
