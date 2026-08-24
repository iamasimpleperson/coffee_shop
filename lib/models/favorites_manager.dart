import 'dart:convert';
import 'package:coffee_shop/services/mock_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/coffee/screens/choose_coffee.dart';

class FavoritesNotifier extends Notifier<List<CoffeeOption>> {
  @override
  List<CoffeeOption> build() {
    return [];
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteData = prefs.getStringList('favorite_data') ?? [];

    final coffees = await MockDataService.getCoffees();

    final List<CoffeeOption> loadedFavorites = [];
    for (String dataStr in favoriteData) {
      try {
        final Map<String, dynamic> data = jsonDecode(dataStr);
        final String id = data['id'];
        final String? size = data['size'];
        final String? flavor = data['flavor'];

        final model = coffees.firstWhere((element) => element.id == id);

        IconData iconData = Icons.coffee;
        if (model.name.contains('Latte')) iconData = Icons.local_cafe;
        if (model.name.contains('Espresso')) {
          iconData = Icons.local_cafe_outlined;
        }

        loadedFavorites.add(
          CoffeeOption(
            id: model.id,
            name: model.name,
            icon: iconData,
            size: size,
            flavor: flavor,
          ),
        );
      } catch (e) {
        // Skip if option no longer exists in mock data or JSON is invalid
      }
    }
    state = loadedFavorites;
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final dataList = state.map((e) {
      return jsonEncode({
        'id': e.id,
        'size': e.size,
        'flavor': e.flavor,
      });
    }).toList();
    await prefs.setStringList('favorite_data', dataList);
  }

  void toggleFavorite(CoffeeOption option) {
    final current = List<CoffeeOption>.from(state);
    // Identify by ID
    if (current.any((fav) => fav.id == option.id)) {
      current.removeWhere((fav) => fav.id == option.id);
    } else {
      current.add(option);
    }
    state = current;
    _saveFavorites();
  }

  bool isFavorite(CoffeeOption option) {
    return state.any((fav) => fav.id == option.id);
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<CoffeeOption>>(() {
  return FavoritesNotifier();
});
