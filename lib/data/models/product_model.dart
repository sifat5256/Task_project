import 'package:task_project/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.thumbnail,
    required super.description,
    required super.brand,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] as String? ?? '',
      description: json['description'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'description': description,
      'brand': brand,
      'category': category,
    };
  }
}
