import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/Cart.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> apiCarts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    const url = "https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok1/cart";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> cartList = responseData['data'];
        
        setState(() {
          apiCarts = cartList.map((json) => Cart.fromJson(json)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Your Cart", style: TextStyle(color: Colors.black)),
            Text(
              "${apiCarts.length} items",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator()) // Loading indicator
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: apiCarts.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(apiCarts[index].name), // Gunakan nama sebagai key karena API tidak ada ID
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      apiCarts.removeAt(index);
                    });
                  },
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: CartCard(cart: apiCarts[index]),
                ),
              ),
            ),
          ),
      bottomNavigationBar: CheckoutCard(carts: apiCarts),
    );
  }
}