import 'package:flutter/material.dart';
import '../../../models/Cart.dart';

class CheckoutCard extends StatelessWidget {
  final List<Cart> carts;
  
  const CheckoutCard({Key? key, required this.carts}) : super(key: key);

  // Menghitung total harga dari semua item
  double calculateTotal() {
    return carts.fold(0, (sum, item) => sum + item.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ... (style dekorasi tetap sama seperti kode awal kamu)
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ... (Row Voucher tetap sama)
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "Rp ${calculateTotal()}",
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Check Out"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}