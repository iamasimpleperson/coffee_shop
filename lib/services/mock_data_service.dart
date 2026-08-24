import 'package:coffee_shop/models/coffee_model.dart';
import 'package:coffee_shop/features/store/models/store_product.dart';

class MockDataService {
  // Simulate network delay
  static Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  static Future<List<CoffeeModel>> getCoffees() async {
    await _delay();
    return [
      CoffeeModel(
        id: 'c1',
        name: 'Cappuccino',
        description: 'A classic Italian coffee drink that is traditionally prepared with equal parts double espresso, steamed milk, and steamed milk foam.',
        price: 4.50,
        imageUrl: '', // Placeholder for now
        rating: 4.8,
      ),
      CoffeeModel(
        id: 'c2',
        name: 'Latte',
        description: 'A milk coffee that is a made up of one or two shots of espresso, steamed milk and a final, thin layer of frothed milk on top.',
        price: 4.00,
        imageUrl: '',
        rating: 4.6,
      ),
      CoffeeModel(
        id: 'c3',
        name: 'Latte Macchiato',
        description: 'A coffee beverage; the name literally means "stained milk".',
        price: 4.80,
        imageUrl: '',
        rating: 4.7,
      ),
      CoffeeModel(
        id: 'c4',
        name: 'Espresso',
        description: 'A coffee-brewing method of Italian origin, in which a small amount of nearly boiling water is forced under pressure through finely-ground coffee beans.',
        price: 3.00,
        imageUrl: '',
        rating: 4.9,
      ),
      CoffeeModel(
        id: 'c5',
        name: 'Double Espresso',
        description: 'Two shots of espresso in one cup.',
        price: 4.50,
        imageUrl: '',
        rating: 4.9,
      ),
      CoffeeModel(
        id: 'c6',
        name: 'Americano',
        description: 'A type of coffee drink prepared by diluting an espresso with hot water, giving it a similar strength to, but different flavor from, traditionally brewed coffee.',
        price: 3.50,
        imageUrl: '',
        rating: 4.5,
      ),
    ];
  }

  static Future<List<StoreProduct>> getStoreProducts() async {
    await _delay();
    // Re-using the existing mockStoreProducts
    return mockStoreProducts;
  }
}
