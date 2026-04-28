import 'package:flutter/material.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../../services/api_service.dart';
import '../details/details_screen.dart'; 

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  static String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<Product>>(
            future: ApiService().fetchProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              final products = snapshot.data ?? [];

              return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => ProductCard(
                  product: products[index],
                  onPress: () => Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: ProductDetailsArguments(product: products[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}