import 'package:coffee_shop/models/coffee_model.dart';
import 'package:coffee_shop/services/api_client.dart';

class CoffeeService {
  final ApiClient _client = ApiClient();

  /// GET all coffees
  Future<List<CoffeeModel>> getCoffees() async {
    final data = await _client.get('/api/v1/coffees/');
    
    if (data != null && data is List) {
      return data.map((item) => CoffeeModel.fromJson(item)).toList();
    }
    return [];
  }

  /// GET a single coffee by ID
  Future<CoffeeModel?> getCoffeeById(String id) async {
    final data = await _client.get('/api/v1/coffees/$id');
    
    if (data != null) {
      return CoffeeModel.fromJson(data);
    }
    return null;
  }

  /// POST (Create) a new coffee
  Future<CoffeeModel?> createCoffee(CoffeeModel coffee) async {
    final data = await _client.post(
      '/api/v1/coffees/',
      coffee.toJson(),
    );

    if (data != null) {
      return CoffeeModel.fromJson(data);
    }
    return null;
  }

  /// PUT (Update) an existing coffee
  Future<CoffeeModel?> updateCoffee(String id, CoffeeModel coffee) async {
    final data = await _client.put(
      '/api/v1/coffees/$id',
      coffee.toJson(),
    );

    if (data != null) {
      return CoffeeModel.fromJson(data);
    }
    return null;
  }

  /// DELETE a coffee
  Future<bool> deleteCoffee(String id) async {
    final data = await _client.delete('/api/v1/coffees/$id');
    return data != null; // Returns true if successful
  }
}
