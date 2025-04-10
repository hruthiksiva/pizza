class Pizza {
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;

  Pizza({required this.id, required this.name, required this.description, required this.price, required this.image});

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}
