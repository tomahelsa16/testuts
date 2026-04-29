import 'Product.dart';

class Cart {
  final String name;
  final int price;
  final int numOfItem;
  final int totalPrice;

  Cart({
    required this.name,
    required this.price,
    required this.numOfItem,
    required this.totalPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      name: json['name'],
      price: json['price'],
      numOfItem: json['count'],
      totalPrice: json['total_price'],
    );
  }
}