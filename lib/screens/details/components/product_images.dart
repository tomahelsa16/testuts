import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: widget.product.images[selectedImage].startsWith("http")
                ? Image.network(widget.product.images[selectedImage])
                : Image.asset(widget.product.images[selectedImage]),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.product.images.length,
            (index) => buildSmallProductImage(index),
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductImage(int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedImage = index),
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48, width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: widget.product.images[index].startsWith("http")
            ? Image.network(widget.product.images[index])
            : Image.asset(widget.product.images[index]),
      ),
    );
  }
}