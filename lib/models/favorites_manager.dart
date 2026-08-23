import 'package:flutter/foundation.dart';
import '../features/coffee/screens/choose_coffee.dart';

class FavoritesManager {
  static final ValueNotifier<List<CoffeeOption>> favoritesNotifier = ValueNotifier<List<CoffeeOption>>([]);

  static void toggleFavorite(CoffeeOption option) {
    final current = List<CoffeeOption>.from(favoritesNotifier.value);
    if (current.any((fav) => fav.id == option.id)) {
      current.removeWhere((fav) => fav.id == option.id);
    } else {
      current.add(option);
    }
    favoritesNotifier.value = current;
  }

  static bool isFavorite(CoffeeOption option) {
    return favoritesNotifier.value.any((fav) => fav.id == option.id);
  }
}
