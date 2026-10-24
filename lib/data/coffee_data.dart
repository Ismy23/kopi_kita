import 'package:flutter/foundation.dart';
import '../models/coffee.dart';

/// Data dummy berbentuk JSON (List<Map>).
/// Nanti cukup diganti dengan hasil response API, lalu di-parse
/// memakai Coffee.fromJson().
const List<Map<String, dynamic>> _dummyJson = [
  {
    'id': 1,
    'name': 'Espresso',
    'category': 'Kopi',
    'description':
        'Kopi pekat dengan crema tebal. Rasa kuat dan aromanya khas, cocok untuk kamu yang butuh semangat cepat.',
    'price': 18000,
    'calories': 5,
    'rating': 4.6,
    'ingredients': ['Biji kopi arabika', 'Air'],
    'icon': 'maker',
    'color': 0xFF6F4E37,
    'is_popular': true,
    'is_new': false,
  },
  {
    'id': 2,
    'name': 'Cafe Latte',
    'category': 'Kopi',
    'description':
        'Perpaduan espresso dan susu steamed yang lembut. Ringan, creamy, dan mudah dinikmati kapan saja.',
    'price': 28000,
    'calories': 190,
    'rating': 4.8,
    'ingredients': ['Espresso', 'Susu segar', 'Foam susu'],
    'icon': 'coffee',
    'color': 0xFFA67B5B,
    'is_popular': true,
    'is_new': false,
  },
  {
    'id': 3,
    'name': 'Caramel Macchiato',
    'category': 'Kopi',
    'description':
        'Espresso dengan susu vanila dan lapisan saus karamel manis di atasnya.',
    'price': 32000,
    'calories': 250,
    'rating': 4.7,
    'ingredients': ['Espresso', 'Susu', 'Sirup vanila', 'Saus karamel'],
    'icon': 'cafe',
    'color': 0xFFD98E04,
    'is_popular': true,
    'is_new': true,
  },
  {
    'id': 4,
    'name': 'Es Kopi Susu Aren',
    'category': 'Kopi',
    'description':
        'Kopi susu dingin dengan gula aren asli. Manisnya pas, segar, dan jadi favorit banyak orang.',
    'price': 25000,
    'calories': 210,
    'rating': 4.9,
    'ingredients': ['Espresso', 'Susu', 'Gula aren', 'Es batu'],
    'icon': 'drink',
    'color': 0xFF8D6E63,
    'is_popular': true,
    'is_new': false,
  },
  {
    'id': 5,
    'name': 'Matcha Latte',
    'category': 'Non-Kopi',
    'description':
        'Matcha premium yang dikocok dengan susu. Rasa earthy, creamy, dan tidak mengandung kopi.',
    'price': 30000,
    'calories': 180,
    'rating': 4.5,
    'ingredients': ['Bubuk matcha', 'Susu', 'Sirup gula'],
    'icon': 'drink',
    'color': 0xFF7CA57A,
    'is_popular': false,
    'is_new': true,
  },
  {
    'id': 6,
    'name': 'Cokelat Hangat',
    'category': 'Non-Kopi',
    'description':
        'Cokelat pekat dengan susu hangat dan sedikit krim. Cocok diminum saat hujan.',
    'price': 26000,
    'calories': 280,
    'rating': 4.4,
    'ingredients': ['Dark chocolate', 'Susu', 'Whipped cream'],
    'icon': 'cafe',
    'color': 0xFF5D4037,
    'is_popular': false,
    'is_new': false,
  },
  {
    'id': 7,
    'name': 'Croissant Butter',
    'category': 'Makanan',
    'description':
        'Croissant renyah di luar, lembut di dalam, dipanggang segar setiap pagi dengan butter berkualitas.',
    'price': 22000,
    'calories': 310,
    'rating': 4.6,
    'ingredients': ['Tepung', 'Butter', 'Telur', 'Ragi'],
    'icon': 'bakery',
    'color': 0xFFE0A458,
    'is_popular': false,
    'is_new': true,
  },
  {
    'id': 8,
    'name': 'Roti Bakar Keju',
    'category': 'Makanan',
    'description':
        'Roti tebal dipanggang dengan keju leleh dan taburan susu. Teman ngopi yang pas.',
    'price': 20000,
    'calories': 340,
    'rating': 4.3,
    'ingredients': ['Roti tawar', 'Keju cheddar', 'Mentega', 'Susu kental'],
    'icon': 'bakery',
    'color': 0xFFC98B4B,
    'is_popular': false,
    'is_new': false,
  },
  {
    'id': 9,
    'name': 'Tiramisu Slice',
    'category': 'Dessert',
    'description':
        'Kue berlapis mascarpone dan biskuit yang dicelup espresso, ditaburi bubuk kakao.',
    'price': 35000,
    'calories': 420,
    'rating': 4.8,
    'ingredients': ['Mascarpone', 'Espresso', 'Biskuit ladyfinger', 'Kakao'],
    'icon': 'cake',
    'color': 0xFFB5838D,
    'is_popular': false,
    'is_new': true,
  },
  {
    'id': 10,
    'name': 'Affogato',
    'category': 'Dessert',
    'description':
        'Es krim vanila yang disiram espresso panas. Manis, pahit, panas, dan dingin jadi satu.',
    'price': 29000,
    'calories': 230,
    'rating': 4.7,
    'ingredients': ['Es krim vanila', 'Espresso'],
    'icon': 'icecream',
    'color': 0xFFBC8F6F,
    'is_popular': false,
    'is_new': false,
  },
];

final List<Coffee> allCoffees =
    _dummyJson.map((e) => Coffee.fromJson(e)).toList();

const List<String> categories = ['Semua', 'Kopi', 'Non-Kopi', 'Makanan', 'Dessert'];

/// State global sederhana (tanpa package tambahan).
final ValueNotifier<Set<int>> favorites = ValueNotifier<Set<int>>({});
final ValueNotifier<String> selectedCategory = ValueNotifier<String>('Semua');

void toggleFavorite(int id) {
  final next = Set<int>.from(favorites.value);
  if (!next.add(id)) next.remove(id);
  favorites.value = next;
}
