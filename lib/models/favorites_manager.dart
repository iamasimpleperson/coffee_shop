import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/coffee/screens/choose_coffee.dart';

class FavoritesManager {
  static final ValueNotifier<List<CoffeeOption>> favoritesNotifier = ValueNotifier<List<CoffeeOption>>([]);

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    
    final List<CoffeeOption> loadedFavorites = [];
    for (String id in favoriteIds) {
      try {
        final option = mockCoffeeOptions.firstWhere((element) => element.id == id);
        loadedFavorites.add(option);
      } catch (e) {
        // Skip if option no longer exists in mock data
      }
    }
    favoritesNotifier.value = loadedFavorites;
  }

  static Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = favoritesNotifier.value.map((e) => e.id).toList();
    await prefs.setStringList('favorite_ids', ids);
  }

  static void toggleFavorite(CoffeeOption option) {
    final current = List<CoffeeOption>.from(favoritesNotifier.value);
    if (current.any((fav) => fav.id == option.id)) {
      current.removeWhere((fav) => fav.id == option.id);
    } else {
      current.add(option);
    }
    favoritesNotifier.value = current;
    _saveFavorites();
  }

  static bool isFavorite(CoffeeOption option) {
    return favoritesNotifier.value.any((fav) => fav.id == option.id);
  }
}
