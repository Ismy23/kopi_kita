import 'package:flutter/material.dart';

/// Model data menu. Struktur dibuat dengan fromJson / toJson
/// supaya nanti mudah dihubungkan ke API (tinggal ganti sumber data).
class Coffee {
  final int id;
  final String name;
  final String category;
  final String description;
  final int price;
  final int calories;
  final double rating;
  final List<String> ingredients;
  final String iconKey;
  final int colorValue;
  final bool isPopular;
  final bool isNew;

  const Coffee({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.calories,
    required this.rating,
    required this.ingredients,
    required this.iconKey,
    required this.colorValue,
    this.isPopular = false,
    this.isNew = false,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      calories: json['calories'] as int,
      rating: (json['rating'] as num).toDouble(),
      ingredients: List<String>.from(json['ingredients'] as List),
      iconKey: json['icon'] as String,
      colorValue: json['color'] as int,
      isPopular: json['is_popular'] as bool? ?? false,
      isNew: json['is_new'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'price': price,
        'calories': calories,
        'rating': rating,
        'ingredients': ingredients,
        'icon': iconKey,
        'color': colorValue,
        'is_popular': isPopular,
        'is_new': isNew,
      };

  Color get color => Color(colorValue);

  Color get colorDark {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0)).toColor();
  }

  IconData get icon {
    switch (iconKey) {
      case 'coffee':
        return Icons.coffee_rounded;
      case 'maker':
        return Icons.coffee_maker_rounded;
      case 'cafe':
        return Icons.local_cafe_rounded;
      case 'bakery':
        return Icons.bakery_dining_rounded;
      case 'cake':
        return Icons.cake_rounded;
      case 'drink':
        return Icons.local_drink_rounded;
      case 'icecream':
        return Icons.icecream_rounded;
      default:
        return Icons.restaurant_rounded;
    }
  }

  String get priceText => formatRupiah(price);
}

String formatRupiah(int value) {
  final s = value.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]}.',
      );
  return 'Rp $s';
}
