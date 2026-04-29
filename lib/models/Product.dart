import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  String get formattedPrice {
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  factory Product.fromJson(Map<String, dynamic> json, int index) {
    return Product(
      id: index,
      title: json['name'] ?? "",
      description: "Nikmati sajian lezat ${json['name']} dengan kualitas terbaik.",
      images: [json['image'] ?? ""],
      rating: (json['star'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isPopular: true,
      colors: [
        const Color(0xFFF6625E),
        const Color(0xFF836DB8),
        const Color(0xFFDECB9C),
        Colors.white,
      ],
    );
  }
}