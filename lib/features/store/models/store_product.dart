class StoreProduct {
  final String id;
  final String name;
  final String category; // 'Beans' or 'Care'
  final String subtitle;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> sizes; // e.g. '250g', '500g', '1kg'
  final String? taste;
  final String? sweetness;

  StoreProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.sizes = const [],
    this.taste,
    this.sweetness,
  });
}

final List<StoreProduct> mockStoreProducts = [
  // Beans
  StoreProduct(
    id: 'b1',
    name: 'Extra blend',
    category: 'Beans',
    subtitle: 'Light roast',
    description:
        'An espresso purposely blended to conjure hints of classic sweets, like tutti frutti or wine gums.',
    price: 9.00,
    imageUrl: '', // We'll use a placeholder icon/color
    sizes: ['250g', '500g', '1kg'],
    taste: 'Milk chocolate',
    sweetness: 'Toffee',
  ),
  StoreProduct(
    id: 'b2',
    name: 'House blend',
    category: 'Beans',
    subtitle: 'Medium roast',
    description:
        'A well-balanced, reliable house blend perfect for daily drinking.',
    price: 11.00,
    imageUrl: '',
    sizes: ['250g', '500g', '1kg'],
    taste: 'Nutty',
    sweetness: 'Caramel',
  ),
  StoreProduct(
    id: 'b3',
    name: 'Sunshine blend',
    category: 'Beans',
    subtitle: 'Dark roast',
    description: 'Rich, dark and full-bodied for a strong start to the day.',
    price: 9.00,
    imageUrl: '',
    sizes: ['250g', '500g', '1kg'],
    taste: 'Dark chocolate',
    sweetness: 'Maple',
  ),

  // Care
  StoreProduct(
    id: 'c1',
    name: 'Yellow mug',
    category: 'Care',
    subtitle: 'Ceramic mug',
    description: 'A beautiful, sturdy ceramic mug for your daily brew.',
    price: 11.00,
    imageUrl: '',
    sizes: [],
  ),
  StoreProduct(
    id: 'c2',
    name: 'Descaling solution',
    category: 'Care',
    subtitle: '250ml',
    description:
        'Keep your machine in top condition with this official descaler.',
    price: 18.00,
    imageUrl: '',
    sizes: ['250ml'],
  ),
  StoreProduct(
    id: 'c3',
    name: 'Water filter',
    category: 'Care',
    subtitle: 'Replacement pack',
    description: 'Ensure the purest water for the best tasting coffee.',
    price: 24.00,
    imageUrl: '',
    sizes: [],
  ),
];
