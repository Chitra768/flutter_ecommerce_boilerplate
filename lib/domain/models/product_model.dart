class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'];
    double ratingValue = 0.0;
    if (ratingData is Map) {
      final rate = ratingData['rate'];
      if (rate != null) {
        ratingValue = rate is int ? rate.toDouble() : (rate as num).toDouble();
      }
    }
    return Product(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : 0.0,
      imageUrl: json['image']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      rating: ratingValue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': imageUrl,
      'category': category,
      'rating': {'rate': rating},
    };
  }
}
