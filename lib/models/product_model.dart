class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  bool liked; // Added this property
  
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.liked = false, // Default value is false
  });
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      liked: json['liked'] ?? false, // Parse from JSON if available, otherwise default to false
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'liked': liked, // Include in JSON
    };
  }
}