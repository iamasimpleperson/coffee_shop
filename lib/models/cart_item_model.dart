import 'coffee_model.dart';

class CartItemModel {
  final String id;
  final CoffeeModel coffee;
  final int quantity;
  final String size;

  CartItemModel({
    required this.id,
    required this.coffee,
    this.quantity = 1,
    this.size = 'M',
  });

  double get totalPrice => coffee.price * quantity;

  CartItemModel copyWith({
    String? id,
    CoffeeModel? coffee,
    int? quantity,
    String? size,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      coffee: coffee ?? this.coffee,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }
}
