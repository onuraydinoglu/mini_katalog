class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final double price;
  final String currency;
  final String image;
  final Map<String, dynamic> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final priceText = (json['price'] as String)
        .replaceAll('\$', '')
        .replaceAll(',', '');

    return Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      price: double.parse(priceText),
      currency: json['currency'] as String,
      image: json['image'] as String,
      specs: Map<String, dynamic>.from(json['specs'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': '\$${price.toStringAsFixed(2)}',
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }
}
