class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});

  Map<String, dynamic> toMap() =>
      {'name': name, 'price': price, 'image': image};

  factory Product.fromMap(Map<String, dynamic> map) =>
      Product(name: map['name'], price: map['price'], image: map['image']);
}
