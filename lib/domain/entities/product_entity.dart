import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String description;
  final String brand;
  final String category;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.description,
    required this.brand,
    required this.category,
  });

  @override
  List<Object> get props => [
        id,
        title,
        price,
        thumbnail,
        description,
        brand,
        category,
      ];
}
